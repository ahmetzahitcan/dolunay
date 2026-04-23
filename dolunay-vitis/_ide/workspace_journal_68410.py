# 2026-04-22T15:24:55.165531618
import vitis

client = vitis.create_client()
client.set_workspace(path="dolunay-vitis")

platform = client.create_platform_component(name = "cmod_a7_35t",hw_design = "$COMPONENT_LOCATION/../../cmod_a7_35t.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0",compiler = "gcc")

comp = client.create_app_component(name="hello_app",platform = "$COMPONENT_LOCATION/../cmod_a7_35t/export/cmod_a7_35t/cmod_a7_35t.xpfm",domain = "standalone_microblaze_0")

platform = client.get_component(name="cmod_a7_35t")
status = platform.build()

comp = client.get_component(name="hello_app")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

