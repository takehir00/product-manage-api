name := """okuyamaProductAPI"""
organization := "com.example"

version := "1.0-SNAPSHOT"

lazy val root = (project in file(".")).enablePlugins(PlayJava, PlayEbean)

scalaVersion := "2.12.4"

libraryDependencies += guice

libraryDependencies += "mysql" % "mysql-connector-java" % "8.0.11"
libraryDependencies ++= Seq(
  javaJdbc,
  evolutions,

)

// https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk
libraryDependencies += "com.amazonaws" % "aws-java-sdk" % "1.11.556"


libraryDependencies ++= Seq(
  ws
)

libraryDependencies += filters
