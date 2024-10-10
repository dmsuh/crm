<template>
  <div class="about">
    <div style="min-width: 400px;">
      <div style="display: flex; justify-content: end">
        <crm-dropdown @update:selectedOption="handleSelection" :options="options"></crm-dropdown>
        <crm-btn :disabled="btnRef.disabled&&name==='none'" :is-loading="btnRef.isLoading" :button-text="btnRef.text"
                 @click="click"></crm-btn>
      </div>
      <div v-if="dataStore.value.length>0" class="scroll-container">
        <div
            v-for="item in dataShow"
            :key="item.id"
            class="item"
        >
          <span>ID: {{ item.id }}</span> - <span>Name: {{ item.name }}</span>
        </div>
      </div>
    </div>

  </div>
</template>
<script setup lang="ts">

import CrmDropdown from "@/components/CrmDropdown.vue";
import {computed, onMounted, ref} from "vue";
import {Option} from "@/utils/models";
import CrmBtn from "@/components/CrmBtn.vue";
import {useDataStore} from "@/stores/counter";

const store = useDataStore();


const dataStore = computed(() => store.getData)
const dataShow = ref(dataStore.value)
const name = ref('none')
const click = async () => {
  btnRef.value.isLoading = true
  btnRef.value.disabled = true
  await store.addData(name.value)
  btnRef.value.isLoading = false
  btnRef.value.disabled = false
}
const btnRef = ref({isLoading: false, text: 'Добавить', disabled: false})
const handleSelection = (value: string) => {
  name.value = value
}
const options = ref(<Option[]>[{name: 'none', label: "Не выбрано"}, {name: 'lead', label: "Сделка"}, {
  name: 'contact',
  label: "Контакт"
}, {name: 'company', label: "Компания"}])

onMounted(() => {
  store.auth()
})
</script>

<style>
.scroll-container {
  max-height: 500px;
  overflow-y: auto;
  border: 1px solid #655454;
  padding: 10px;
  border-radius: 5px;
  background-color: #030303;
  display: flex;
  flex-direction: column;
}

.item {
  padding: 8px;
  margin: 5px 0;
  border: 1px solid #866363;
  border-radius: 4px;
  background-color: #380909;
  transition: background-color 0.2s;
}

.item:hover {
  background-color: rgba(50, 7, 25, 0.99);
}

@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
