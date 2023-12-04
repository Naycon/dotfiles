local config = {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function()
    local jdtls = require("jdtls")
    jdtls.setup_dap({ hotcodereplace = "auto" })
    jdtls.setup.add_commands()
  end,
  cmd = {'jdtls'},
  init_options = {
    bundles = java_bundles,
    extendedClientCapabilities = {
      progressReportProvider = false,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
      moveRefactoringSupport = true,
      inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
      resolveAdditionalTextEditsSupport = true,
    },
  },
  settings = {
    java = {
      trace = {
        server = "error",
      },
      maven = {
        downloadSources = true,
        updateSnapshots = false,
      },
      ["import.maven.enabled"] = true,
      ["referencesCodeLens.enabled"] = true,
      ["implementationsCodeLens.enabled"] = true,
      ["autobuild.enabled"] = true,
      ["configuration.updateBuildConfiguration"] = true,
      ["saveActions.organizeImports"] = true,
      configuration = {
        {
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-amazon-corretto",
        },
      },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
          "org.mockito.BDDMockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.assertj.core.api.Assertions.*",
        },
        importOrder = {
          "com",
          "java",
          "javax",
          "org",
        },
      },
    },
  },
}
require('jdtls').start_or_attach(config)
