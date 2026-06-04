import QtQuick
import QtQuick3D

Node {
    id: node
    property alias glowStrength: engine_glow_material.glowStrength
    // Resources
    PrincipledMaterial {
        id: light_bulb_material
        objectName: "light_bulb"
        baseColor: "#ffe7d6a8"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: light_metal_material
        objectName: "light_metal"
        baseColor: "#ff949494"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: tubes_material
        objectName: "tubes"
        baseColor: "#ff746844"
        roughness: 0.8783850073814392
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: yellow_material
        objectName: "yellow"
        baseColor: "#ffe7ba38"
        roughness: 0.806350827217102
        emissiveFactor: Qt.vector3d(1, 1, 0.245757)
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: elsa_pillow_2_material
        objectName: "Elsa_pillow_2"
        baseColor: "#ff573722"
        roughness: 0.8500000238418579
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_001_material
        objectName: "Material.001"
        baseColor: "#ff4b2c17"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_005_material
        objectName: "Material.005"
        baseColor: "#ff3b3d3f"
        roughness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_006_material
        objectName: "Material.006"
        baseColor: "#ff3e4a5c"
        roughness: 0.5492924451828003
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: black_material
        objectName: "black"
        baseColor: "#ff1b1b1b"
        roughness: 0.037752915173769
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: flashlight_material
        objectName: "flashlight"
        baseColor: "#ff535b34"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: metal_material
        objectName: "metal"
        baseColor: "#ff616161"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
    id: engine_glow_material

    property real glowStrength: 1.0

    objectName: "Engine_glow"
    baseColor: "#ff1587e7"

    roughness: 0.806350827217102

    emissiveFactor: Qt.vector3d(
        glowStrength,
        glowStrength,
        glowStrength
    )

    cullMode: PrincipledMaterial.NoCulling
    alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: glass_material
        objectName: "Glass"
        baseColor: "#40e7e7e7"
        roughness: 0.3428151309490204
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Blend
        transmissionFactor: 1
    }
    PrincipledMaterial {
        id: glass_001_material
        objectName: "Glass.001"
        baseColor: "#49d5ecff"
        roughness: 1
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Blend
        transmissionFactor: 0.713259756565094
    }
    PrincipledMaterial {
        id: material_material
        objectName: "Material"
        baseColor: "#ff505050"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_002_material
        objectName: "Material.002"
        baseColor: "#ff626262"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_003_material
        objectName: "Material.003"
        baseColor: "#ffe7e7e7"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_004_material
        objectName: "Material.004"
        baseColor: "#ffe7e7e7"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: material_007_material
        objectName: "Material.007"
        baseColor: "#ff24463d"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: tires_material
        objectName: "Tires"
        baseColor: "#ff131313"
        roughness: 0.9513540267944336
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: flashlight_textured_material
        objectName: "flashlight_textured"
        baseColor: "#ff535b34"
        roughness: 0.806350827217102
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }
    PrincipledMaterial {
        id: grey_material
        objectName: "grey"
        baseColor: "#ff5e5e5e"
        roughness: 0.2152850329875946
        cullMode: PrincipledMaterial.NoCulling
        alphaMode: PrincipledMaterial.Opaque
    }

    // Nodes:
    Node {
        id: sketchfab_model
        objectName: "Sketchfab_model"
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        Node {
            id: space_ship_applied_obj_cleaner_materialmerger_gles
            objectName: "space_ship_applied.obj.cleaner.materialmerger.gles"
            Model {
                id: object_2
                objectName: "Object_2"
                source: "meshes/object_0_mesh.mesh"
                materials: [
                    engine_glow_material
                ]
            }
            Model {
                id: object_3
                objectName: "Object_3"
                source: "meshes/object_1_mesh.mesh"
                materials: [
                    glass_material
                ]
            }
            Model {
                id: object_4
                objectName: "Object_4"
                source: "meshes/object_2_mesh.mesh"
                materials: [
                    glass_001_material
                ]
            }
            Model {
                id: object_5
                objectName: "Object_5"
                source: "meshes/object_3_mesh.mesh"
                materials: [
                    material_material
                ]
            }
            Model {
                id: object_6
                objectName: "Object_6"
                source: "meshes/object_4_mesh.mesh"
                materials: [
                    material_002_material
                ]
            }
            Model {
                id: object_7
                objectName: "Object_7"
                source: "meshes/object_5_mesh.mesh"
                materials: [
                    material_003_material
                ]
            }
            Model {
                id: object_8
                objectName: "Object_8"
                source: "meshes/object_6_mesh.mesh"
                materials: [
                    material_004_material
                ]
            }
            Model {
                id: object_9
                objectName: "Object_9"
                source: "meshes/object_7_mesh.mesh"
                materials: [
                    material_007_material
                ]
            }
            Model {
                id: object_10
                objectName: "Object_10"
                source: "meshes/object_8_mesh.mesh"
                materials: [
                    tires_material
                ]
            }
            Model {
                id: object_11
                objectName: "Object_11"
                source: "meshes/object_9_mesh.mesh"
                materials: [
                    flashlight_textured_material
                ]
            }
            Model {
                id: object_12
                objectName: "Object_12"
                source: "meshes/object_10_mesh.mesh"
                materials: [
                    grey_material
                ]
            }
            Model {
                id: object_13
                objectName: "Object_13"
                source: "meshes/object_11_mesh.mesh"
                materials: [
                    grey_material
                ]
            }
            Model {
                id: object_14
                objectName: "Object_14"
                source: "meshes/object_12_mesh.mesh"
                materials: [
                    light_bulb_material
                ]
            }
            Model {
                id: object_15
                objectName: "Object_15"
                source: "meshes/object_13_mesh.mesh"
                materials: [
                    light_metal_material
                ]
            }
            Model {
                id: object_16
                objectName: "Object_16"
                source: "meshes/object_14_mesh.mesh"
                materials: [
                    tubes_material
                ]
            }
            Model {
                id: object_17
                objectName: "Object_17"
                source: "meshes/object_15_mesh.mesh"
                materials: [
                    yellow_material
                ]
            }
            Model {
                id: object_18
                objectName: "Object_18"
                source: "meshes/object_16_mesh.mesh"
                materials: [
                    elsa_pillow_2_material
                ]
            }
            Model {
                id: object_19
                objectName: "Object_19"
                source: "meshes/object_17_mesh.mesh"
                materials: [
                    elsa_pillow_2_material
                ]
            }
            Model {
                id: object_20
                objectName: "Object_20"
                source: "meshes/object_18_mesh.mesh"
                materials: [
                    elsa_pillow_2_material
                ]
            }
            Model {
                id: object_21
                objectName: "Object_21"
                source: "meshes/object_19_mesh.mesh"
                materials: [
                    material_001_material
                ]
            }
            Model {
                id: object_22
                objectName: "Object_22"
                source: "meshes/object_20_mesh.mesh"
                materials: [
                    material_005_material
                ]
            }
            Model {
                id: object_23
                objectName: "Object_23"
                source: "meshes/object_21_mesh.mesh"
                materials: [
                    material_006_material
                ]
            }
            Model {
                id: object_24
                objectName: "Object_24"
                source: "meshes/object_22_mesh.mesh"
                materials: [
                    black_material
                ]
            }
            Model {
                id: object_25
                objectName: "Object_25"
                source: "meshes/object_23_mesh.mesh"
                materials: [
                    flashlight_material
                ]
            }
            Model {
                id: object_26
                objectName: "Object_26"
                source: "meshes/object_24_mesh.mesh"
                materials: [
                    metal_material
                ]
            }
        }
    }

    // Animations:
}
