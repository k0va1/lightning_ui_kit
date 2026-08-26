import esbuild from 'esbuild';

const isProduction = process.env.NODE_ENV === 'production';
const outdir = isProduction ? 'app/assets/vendor' : 'app/assets/builds';

const options = {
  entryPoints: ['app/javascript/lightning_ui_kit/index.js'],
  bundle: true,
  minify: true,
  outfile: `${outdir}/lightning_ui_kit.js`,
  sourcemap: !isProduction,
  target: 'es6',
  platform: 'browser',
  logLevel: 'info'
};

try {
  if (isProduction) {
    await esbuild.build(options);
  } else {
    const context = await esbuild.context(options);
    await context.watch();
  }
} catch {
  process.exit(1);
}
