#!/usr/bin/env bash

# Load helper functions and set initial variables
vendir sync
. ./vendir/demo-magic/demo-magic.sh
export TYPE_SPEED=100
export DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
TEMP_DIR="project-example"
PROMPT_TIMEOUT=5

# Function to pause and clear the screen
function talkingPoint() {
  wait
  clear
}

# Initialize SDKMAN and install required Java versions
function initSDKman() {
  local sdkman_init="${SDKMAN_DIR:-$HOME/.sdkman}/bin/sdkman-init.sh"
  if [[ -f "$sdkman_init" ]]; then
    source "$sdkman_init"
  else
    echo "SDKMAN not found. Please install SDKMAN first."
    exit 1
  fi
  sdk update
  sdk install java 21.0.1-graalce
  sdk install springboot
}

# Prepare the working directory
function init {
  rm -rf "$TEMP_DIR"
  mkdir "$TEMP_DIR"
  cd "$TEMP_DIR" || exit
  clear
}

function useJava21 {
  echo "#### Java 21 is GA so lets switch to Java 21"
  echo ""
  pei "sdk use java 21.0.1-graalce"
  pei "java -version"
}

function useSpringBootCli32 {
  echo "#### Switch to Spring Boot CLI 3.2"
  echo ""
  pei "sdk use springboot 3.2.1"
  pei "spring --version"
}

function createProject {
  spring init -d=web,webflux,graphql,data-jdbc,postgresql,native,actuator,prometheus,zipkin,docker-compose --build=maven -n project-example -p jar $TEMP_DIR
}

function addPrometheusGrafana {
  echo "#### Add in Prometheus, Grafana to Docker Compose"
  echo ""
  pei "cp -R resources/project-overlay/* $TEMP_DIR"
  pei "cat resources/compose/compose-overlay.yaml >> $TEMP_DIR/compose.yaml"
  pei "cat $TEMP_DIR/compose.yaml"
}

# Main Flow
initSDKman
init
useJava21
talkingPoint
useSpringBootCli32
talkingPoint
createProject
talkingPoint
addPrometheusGrafana
talkingPoint
