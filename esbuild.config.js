import esbuild from 'esbuild';

const isProduction = process.env.NODE_ENV === 'production';
const outdir = isProduction ? 'app/assets/vendor' : 'app/assets/builds';

esbuild.build({
  entryPoints: ['app/javascript/lightning_ui_kit/index.js'],
  bundle: true,
  minify: true,
  outfile: `${outdir}/lightning_ui_kit.js`,
  sourcemap: !isProduction,
  target: 'es6',
  platform: 'browser',
  logLevel: 'info',
  watch: !isProduction
}).catch(() => process.exit(1));
