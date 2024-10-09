<template>
  <div class="about">
    <crm-dropdown @update:selectedOption="handleSelection" :options="options"></crm-dropdown>
    <crm-btn :disabled="btnRef.disabled" :is-loading="btnRef.isLoading" :button-text="btnRef.text"
             @click="click"></crm-btn>
  </div>
</template>

<style>
@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
<script setup lang="ts">

import CrmDropdown from "@/components/CrmDropdown.vue";
import {ref} from "vue";
import {Option} from "@/utils/models";
import CrmBtn from "@/components/CrmBtn.vue";

const click = () => {
  btnRef.value.isLoading = true
  btnRef.value.disabled = true
  setTimeout(() => {
    btnRef.value.isLoading = false
    btnRef.value.disabled = false
  }, 5000)
}
const btnRef = ref({isLoading: false, text: 'Добавить', disabled: false})
const handleSelection = (value: string) => {
  console.log(value)
}
const options = ref(<Option[]>[{name: 'none', label: "Не выбрано"}, {name: 'lead', label: "Сделка"}, {
  name: 'contact',
  label: "Контакт"
}, {name: 'company', label: "Компания"}])
</script>
