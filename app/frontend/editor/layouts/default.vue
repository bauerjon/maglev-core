<template>
  <div class="h-full">
    <header class="flex h-16 border-b border-gray-200">
        <a
          :href="leaveEditorUrl"
          class="w-16 h-full flex justify-center items-center border-r border-gray-200"
          v-tooltip.right="$t('sidebarNav.leaveEditorTooltip')"
        >
          <img v-bind:src="logoUrl" class="w-2/4" />
        </a>
      <div
        class="w-16 h-full flex justify-center items-center border-r border-gray-200"
        v-else
      >
        <img v-bind:src="logoUrl" class="w-2/4" />
      </div>

      <div class="flex flex-grow items-center h-full">
        <slot name="header"> [Layout] Default header </slot>
      </div>
    </header>
    <div class="flex content-area">
      <aside
        class="w-16 flex-shrink-0 flex content-center h-full border-r border-gray-200 relative z-20 bg-white"
      >
        <slot name="sidebar"> [Layout] Default sidebar </slot>
      </aside>
      <main class="bg-gray-100 w-full h-full">
        <slot> [Layout] Default content </slot>
      </main>
    </div>
    <slot name="slide-pane"> </slot>
  </div>
</template>

<script>
export default {
  name: 'MaglevDefaultLayout',
  computed: {
    logoUrl() {
      return this.$store.state.editorSettings.logoUrl
    },
    leaveEditorUrl() {
      return window.leaveUrl;
    },
    pageId() {
      return this.currentPage.pathHash[this.currentLocale]
    },
  },
}
</script>

<style scoped>
.content-area {
  height: calc(100vh - theme('spacing.16'));
}
</style>
