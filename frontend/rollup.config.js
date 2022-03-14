import injectProcessEnv from "rollup-plugin-inject-process-env"
import livereload from "rollup-plugin-livereload"
import resolve from "@rollup/plugin-node-resolve"
import coffee from "rollup-plugin-coffee-script"
import commonjs from "@rollup/plugin-commonjs"
import { terser } from "rollup-plugin-terser"
import css from "rollup-plugin-css-only"

const extensions = [".js", ".coffee"]
const production = !process.env.ROLLUP_WATCH

export default {
  input: "source/main.coffee",
  output: {
    file: "public/build/bundle.js",
    format: "iife",
  },
  plugins: [
    coffee({
      transpile: {
        presets: ["@babel/preset-react"]
      }
    }),

    // we'll extract any component CSS out into
    // a separate file - better for performance
    css({ output: "bundle.css" }),

    resolve({
      browser: true,
      extensions
    }),

    commonjs({ extensions }),

    injectProcessEnv({
      NODE_ENV: production ? "production" : "development",
    }),

    // Watch the `public` directory and refresh the
    // browser on changes when not in production
    !production && livereload("public"),

    production && terser(),
  ],
  watch: {
    clearScreen: false
  }
}
