<template>
  <div class="dropdown">
    <button class="dropdown" @click="toggleDropdown">
      <div class="dropdown-btn">
        <label>{{ selectedOption || 'Select an option' }}</label>
        <svg-icon type="mdi" :path="mdiChevronDown"></svg-icon>
      </div>
    </button>
    <div v-if="isDropdownOpen" class="dropdown-menu">
      <div
          v-for="option in options"
          :key="option"
          class="dropdown-item no-wrap"
          @click="selectOption(option)"
          :style="{backgroundColor:option.label===selectedOption?'grey':'none'}"
      >
        <svg-icon :size="15" v-if="option.label===selectedOption" type="mdi" :path="mdiCheck"></svg-icon>
        {{ option.label }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {mdiCheck, mdiChevronDown} from "@mdi/js"
import SvgIcon from '@jamescoyle/vue-icon'
import {ref} from 'vue';
import {Option} from "@/utils/models";

const props = defineProps<{
  options: Option[];
}>();
const selectedOption = ref<string | null>("Не выбрано");
const isDropdownOpen = ref(false);

const toggleDropdown = () => {
  isDropdownOpen.value = !isDropdownOpen.value;
};

const emit = defineEmits<{
  (e: 'update:selectedOption', value: string): void;
}>();
const selectOption = (option: Option) => {
  selectedOption.value = option.label;
  isDropdownOpen.value = false;
  emit('update:selectedOption', option.name)
};
</script>

<style scoped>
.dropdown {
  justify-content: space-between;
  position: relative;
  display: inline-block;
  font-size: 15px;
  width: 250px;
  min-height: 40px;
}

.dropdown-menu {
  border: 1px solid #ccc;
  background-color: white;
  position: absolute;
  z-index: 1;
  width: 100%;
}

.dropdown-item {
  padding: 10px;
  cursor: pointer;
  color: black;
  font-size: 14px;
}

.dropdown-btn {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.dropdown-item:hover {
  background-color: #f0f0f0;
}
</style>
