<script setup>
import options from "./options.json";
import { createFilters } from 'vue-nix-manual';

const filters = [
  {
    label: "options",
    match: "youtube-music.options",
    checked: false,
  },
  {
    label: "plugins",
    match: "youtube-music.plugins",
    checked: false,
  }
];

const pluginOptions = Object.fromEntries(Object.entries(options).filter(([key, _]) => key.includes("plugins")));
</script>

# Home Manager Module

<SearchOptions :options='options' :filters='filters.concat(createFilters(pluginOptions, 3, 2))' />
