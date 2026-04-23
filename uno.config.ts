import {
  defineConfig,
  presetUno,
  presetAttributify,
  presetIcons,
} from "unocss";

export default defineConfig({
  // Responsive breakpoints
  theme: {
    breakpoints: {
      sm: "640px",
      md: "768px",
      lg: "1024px",
      xl: "1280px",
      "2xl": "1536px",
    },
    colors: {
      primary: "#6b7280",
      secondary: "#ff6f00ff",
    },
  },

  // Presets
  presets: [
    presetUno(),
    presetAttributify(),
    presetIcons({
      scale: 1.2,
      cdn: "https://esm.sh/",
    }),
  ],

  // Shortcuts for common patterns
  shortcuts: {
    // Flex utilities
    "flex-center": "flex items-center justify-center",
    "flex-between": "flex items-center justify-between",
    "flex-col-center": "flex flex-col items-center justify-center",

    // Container
    "container-base": "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8",

    // Button base
    "btn-base": "px-4 py-2 rounded-lg font-medium transition-all duration-200",
    "btn-primary": "btn-base bg-primary text-white hover:bg-primary/90",
    "btn-outline": "btn-base border border-gray-300 hover:bg-gray-100",
  },

  safelist: [
    "bg-primary",
    "text-primary",
    "hover:bg-primary/90",
    "bg-secondary",
    "text-secondary",
  ],
});
