import injectProcessEnv from "rollup-plugin-inject-process-env"
import livereload from "rollup-plugin-livereload"
import resolve from "@rollup/plugin-node-resolve"
import coffee from "rollup-plugin-coffee-script"
import commonjs from "@rollup/plugin-commonjs"
import { terser } from "rollup-plugin-terser"
import css from "rollup-plugin-css-only"

const extensions = [".js", ".coffee"]
const production = !process.env.ROLLUP_WATCH

function serve() {
  let server

  function toExit() {
    if (server) server.kill(0)
  }

  return {
    writeBundle() {
      if (server) return
      server = require("child_process").spawn(
        "npm",
        ["run", "start", "--", "--dev"],
        {
          stdio: ["ignore", "inherit", "inherit"],
          shell: true,
        }
      )

      process.on("SIGTERM", toExit)
      process.on("exit", toExit)
    },
  }
}

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

    !production && serve({
      contentBase: ["public"],
      port: 8080
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
