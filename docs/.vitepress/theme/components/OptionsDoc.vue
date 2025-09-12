<template>
  <div v-if="!!data">
    <hr />
    <div :class="$style['search']">
      <label for="nix-module-search">
        <span class="DocSearch-Button-Container">
          <span class="vp-icon DocSearch-Search-Icon"></span>
        </span>
      </label>
      <input
        id="nix-module-search"
        placeholder="Search"
        spellcheck="false"
        type="search"
        v-model="searchText"
      />
    </div>
    <hr />
    <div v-for="(value, key, _) in data" :key="key">
      <div v-if="searchMatch(key, searchText)">
        <div :class="$style['option-container']">
          <h3 :class="$style['option-title']">
            {{ key.replace(/[^.]+\./, "") }}
          </h3>
          <div :class="$style['option-meta-container']">
            <div :class="$style['option-meta-name']">Name</div>
            <div :class="$style['option-meta-value']">
              <code>{{ key }}</code>
            </div>
            <div :class="$style['option-meta-name']">Description</div>
            <div :class="$style['option-meta-value']">
              <pre
                v-if="value.description.includes('\n')"
                v-html="value.description"
              ></pre>
              <div v-else v-html="value.description"></div>
            </div>
            <div :class="$style['option-meta-name']">Type</div>
            <div :class="$style['option-meta-value']" v-html="value.type"></div>
            <div :class="$style['option-meta-name']" v-if="!!value.default">
              Default
            </div>
            <div :class="$style['option-meta-value']" v-if="!!value.default">
              <code v-html="value.default.text"></code>
            </div>
            <div :class="$style['option-meta-name']" v-if="!!value.example">
              Example
            </div>
            <div :class="$style['option-meta-value']" v-if="!!value.example">
              <div
                v-if="value.example.text.includes('\n')"
                class="language-nix"
              >
                <pre><code v-html="value.example.text"></code></pre>
              </div>
              <code v-else v-html="value.example.text"></code>
            </div>
          </div>
        </div>
        <hr />
      </div>
    </div>
  </div>
</template>

<script setup>
import { useData } from "vitepress";
import { ref, onMounted } from "vue";
import mockedOptions from "./options.mock.json";

const props = defineProps(["file"]);

const searchText = ref("");
const data = ref({});
const { site } = useData();

if (import.meta.env.PROD) {
  onMounted(() =>
    fetch(site.fn().base + props.file)
      .then((res) => res.json())
      .then((json) => (data.value = json))
      .catch(console.log),
  );
} else {
  data.value = mockedOptions;
}

function searchMatch(key, search) {
  return !search || key.includes(search);
}
</script>

<style module>
.search {
  display: flex;
  margin: 24px 0;
  padding: 4px;

  span > span {
    margin: 8px;
  }

  input {
    margin-left: 8px;
    width: 100%;
  }

  &:has(> input:focus),
  &:hover {
    outline: 2px var(--vp-local-search-highlight-bg) solid;
    border-radius: 5px;
  }
}

.option-container {
  padding: 12px 0;
}

.option-title {
  margin: 0 0 16px !important;
}

.option-meta-container {
  display: grid !important;
  grid-template-columns: 100px 1fr;
  row-gap: 0.5em;
  column-gap: 1em;
}

.option-meta-name {
  text-align: right;
}

button {
  font-size: unset;
  text-align: left;
}
</style>
