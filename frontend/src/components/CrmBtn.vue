<template>
  <button :disabled="disabled" @click="handleClick" class="loading-button">
       <span v-if="isLoading" class="loader">
         <crm-loader/>
       </span>
    <span v-else>{{ buttonText }}</span>
  </button>
</template>

<script setup lang="ts">
import CrmLoader from "@/assets/CrmLoader.vue";

const props = defineProps<{
  buttonText: string;
  isLoading: boolean;
  disabled: boolean
}>();
const emit = defineEmits<{
  (e: 'onclick'): void;
}>();
const handleClick = async () => {
  emit('onclick')
}
</script>

<style scoped>
.loading-button {
  min-height: 40px;
  min-width: 40px;
  position: relative;
  padding: 10px 20px;
  font-size: 16px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  background-color: #007bff;
}

.loading-button:disabled {
  background-color: white;
  cursor: wait;
  color: black;
}

.loader {
  position: absolute;
}
</style>
