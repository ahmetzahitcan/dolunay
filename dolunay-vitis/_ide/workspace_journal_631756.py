# 2026-04-22T15:23:27.943893128
import vitis

client = vitis.create_client()
client.set_workspace(path="dolunay-vitis")

platform = client.create_platform_component(name = "cmod_a7_35t",hw_design = "$COMPONENT_LOCATION/../../cmod_a7_35t.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0",compiler = "gcc")

