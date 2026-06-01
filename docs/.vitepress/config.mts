import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "pear-desktop-nix",
  description: "Documentation",
  base: "/pear-desktop-nix/",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [{ text: "Home", link: "/" }],

    sidebar: [
      {
        items: [
          { text: "Introduction", link: "/pages/introduction" },
          { text: "Home Manager Module", link: "/pages/home-manager/" },
          { text: "Virtual Machine", link: "/pages/virtual-machine" },
        ],
      },
    ],

    socialLinks: [
      {
        icon: "github",
        link: "https://github.com/h-banii/pear-desktop-nix",
      },
    ],
  },
  srcDir: "src",
});
