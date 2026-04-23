# 2026-04-23T10:50:39.864135970
import vitis

client = vitis.create_client()
client.set_workspace(path="dolunay-vitis")

platform = client.get_component(name="cmod_a7_35t")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../cmod_a7_35t.xsa")

status = platform.build()

comp = client.get_component(name="hello_app")
comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../cmod_a7_35t.xsa")

status = platform.build()

comp.build()

status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../../cmod_a7_35t.xsa")

status = platform.build()

comp.build()

vitis.dispose()

