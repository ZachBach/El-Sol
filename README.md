# El-Sol

A real-time shader sun in Three.js / WebGL.

A Perlin-noise sphere is rendered into a cube render target, and the sun's surface
shader samples that noise through three independently rotating layers to build a
roiling plasma photosphere — mapped onto a hot, blackbody-style colour ramp
(ember red → orange → yellow → white-hot) with a fresnel corona glowing at the limb.

## How it works

- **`js/shader/`** — simplex noise + fbm (`fragment.glsl`) drawn on a sphere and
  captured into a cubemap (`uPerlin`) via a `CubeCamera` each frame.
- **`js/shaderSun/`** — the sun itself. The vertex shader spins three copies of the
  surface position on different axes (`vLayer0/1/2`); the fragment shader's
  `supersun()` averages the noise cubemap through those layers, colours the result,
  and adds the corona rim.
- **`js/app.js`** — wires the two together: renders the noise cube, then feeds it
  (and `time`) into the sun material.

## Run

```
npm install
npm run dev
```

Open the printed localhost URL. `npm run build` writes a production bundle to
`dist/`. Built with **Vite** + `vite-plugin-glsl`, which imports the `.glsl`
files as strings; `js/app.js` uses modern three (`SphereGeometry`, no removed
`RGBFormat`/`sRGBEncoding`).

## Status

The Perlin→cubemap pipeline and the sun surface + corona are complete and the sun
animates. Possible next steps: sunspots, prominence loops, and a bloom pass.
