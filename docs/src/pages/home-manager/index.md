<script setup>
import { withBase } from 'vitepress'

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
</script>

# Home Manager Module

<SearchOptions :file='withBase("options.json")' :filters='filters' />
