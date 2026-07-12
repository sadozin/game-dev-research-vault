---
title: Fixed timestep and determinism
type: concept
status: active
created: 2026-07-11
updated: 2026-07-11
verified: 2026-07-11
sources:
  - "[[gaffer-fix-your-timestep]]"
  - "[[unity-fixed-timestep]]"
  - "[[gaffer-floating-point-determinism]]"
tags: [game-development, physics, simulation, optimization]
---

# Fixed timestep and determinism

A fixed timestep advances the simulation in identical `dt` increments regardless of how long a frame
took to render. Integrating physics with the last frame's measured delta instead makes behaviour a
function of frame rate: the same scene run at 30 and at 144 frames per second settles differently,
and one long frame can tunnel a body through a wall or blow the integrator up. Decoupling the
simulation rate from the display rate is what makes the result repeatable — and repeatability is the
precondition for physics that behaves the same on every machine, for replays, and for the shared
movement rules that [[client-prediction-and-reconciliation]] depends on.

## Why it works

The frame loop measures elapsed real time and adds it to an accumulator; the simulation then drains
that accumulator in whole `dt` steps, so every integration step sees the same delta. The renderer
produces time and the simulation consumes it in discrete chunks. Because the accumulator rarely
empties exactly, a remainder of unsimulated time is left over each frame, and drawing the last
simulated state directly turns that varying remainder into visible stutter. Keep the previous and
current states and render a blend of them with `alpha = accumulator / dt`: the display stays smooth
and variable-rate while the simulation stays fixed and repeatable. This is the simulation-side
counterpart to [[frame-pacing]] — a steady step feeding a steadily presented frame.

Unity ships this pattern as an engine default: Fixed Timestep is 0.02 s (50 Hz), it drives
`FixedUpdate` and the physics step rather than the frame rate, and a slow frame that spans several
fixed steps produces a backlog Unity runs on the next frame to catch up. Lowering the step buys
accuracy and stability at the cost of more CPU per second of game time; raising it saves CPU and
invites tunnelling and jitter — the same accuracy-versus-cost trade [[game-collision-design]] makes
when choosing how carefully to test for contacts.

## The catch

Catching up is not free, and unbounded catch-up is a failure mode rather than a fix. If the
simulation cannot step faster than real time, each frame falls further behind and demands still more
steps on the next one — the spiral of death — so the elapsed time fed into the accumulator must be
clamped before it is accumulated. Unity's clamp is `Time.maximumDeltaTime`, one third of a second by
default, which bounds the number of `FixedUpdate` calls per frame to `maximumDeltaTime /
fixedDeltaTime`. The clamp buys stability by discarding time: past that threshold Unity does not
simulate the extra time at all, so game time falls behind real time and physics runs slightly slow
while `Time.unscaledTime` keeps tracking the wall clock. That is a deliberate choice of a slow world
over an exploding one, and it means a machine that consistently misses the budget is playing a
subtly different game — one more reason to fix the spike with [[game-performance-profiling]] rather
than widen the clamp.

The deeper catch is that a fixed step gives repeatability, not bit-exactness. The same binary on the
same CPU architecture with the same inputs reproduces its results, but x87's 80-bit intermediates,
under-specified SSE behaviour, compiler reassociation and fused multiply-add, fast-math rewrites, and
transcendental functions that differ between AMD and Intel all break the guarantee the moment the
build, the flags, or the architecture changes. Cross-platform determinism is achievable — pin the
compiler and architecture, force strict IEEE 754 semantics, wrap or avoid the transcendentals, or
move to fixed-point arithmetic — but it costs real engineering effort and measurably slower float
math. Treat "we fixed the timestep, so lockstep will work" as an assumption to be tested, not a
conclusion.

## In practice

Run simulation and rendering on separate clocks: a fixed step for physics, character movement, and
anything whose outcome must be reproducible; a variable step for cameras, interpolation, VFX, and UI,
which only need to look right. Clamp the accumulated frame time and treat hitting that clamp as an
alert, not as normal operation. Interpolate render state between the last two simulated states so a
50 Hz simulation still presents smoothly at 144 Hz, and never read a fixed-step body's transform
straight from a render-rate update without that blend.

If the simulation is shared over the network, keep the authoritative rules inside the fixed step so
the server and the predicting client integrate the same way — the correction path in
[[client-prediction-and-reconciliation]] replays buffered inputs and only converges if each replayed
step is the step the server took, and the server rewind in [[lag-compensation]] can only reconstruct
a past tick that was itself a discrete, recorded step. Where full determinism is not worth its cost,
prefer designs that tolerate divergence, such as the authoritative state exchange in
[[state-synchronization-strategies]], over lockstep schemes that silently desync when one player's
CPU rounds a multiply differently.
