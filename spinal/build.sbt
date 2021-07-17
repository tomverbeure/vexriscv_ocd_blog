
val spinalVersion = "1.5.0"

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.github.spinalhdl",
      scalaVersion := "2.11.12",
      version      := "1.0.0"
    )),
    libraryDependencies ++= Seq(
        "org.scalatest" % "scalatest_2.11" % "2.2.1",
        "org.yaml" % "snakeyaml" % "1.8",
        "com.github.spinalhdl" % "spinalhdl-core_2.11" % spinalVersion,
        "com.github.spinalhdl" % "spinalhdl-lib_2.11"  % spinalVersion,
        compilerPlugin("com.github.spinalhdl" % "spinalhdl-idsl-plugin_2.11" % spinalVersion)
    ),
    name := "vexriscv_ocd"
).dependsOn(vexRiscv)

lazy val vexRiscv = RootProject(file("../VexRiscv.local"))

fork := true
EclipseKeys.withSource := true

