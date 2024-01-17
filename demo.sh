#!/usr/bin/env bash

# Load helper functions and set initial variables
vendir sync
. ./vendir/demo-magic/demo-magic.sh
export TYPE_SPEED=100
export DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PROJECT_NAME="project-example"
TEMP_DIR="$SCRIPTPATH/$PROJECT_NAME"
# Set to 0 to require manual advancing
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
  cd "$TEMP_DIR"
  clear
}

function displayMessage() {
  echo "#### $1"
  echo ""
}

function useJava21 {
  displayMessage "Java 21 is GA so lets switch to Java 21"
  pei "sdk use java 21.0.1-graalce"
  pei "java -version"
}

function useSpringBootCli32 {
  displayMessage "Switch to Spring Boot CLI 3.2"
  pei "sdk use springboot 3.2.1"
  pei "spring --version"
}

function createProject {
  displayMessage "Creating new project"
  pei "cd .."
  pei "spring init -d=web,webflux,graphql,data-jdbc,postgresql,native,actuator,prometheus,zipkin,docker-compose,devtools --build=maven -n project-example -p jar $PROJECT_NAME"
  pei "cd $TEMP_DIR"
}

function addComposeItems {
  displayMessage "Add in Prometheus, Grafana to Docker Compose"
  pei "cp -R $SCRIPTPATH/resources/project-overlay/prometheus-grafana/* ."
  pei "cat $SCRIPTPATH/resources/compose/compose-overlay.yaml >> compose.yaml"
  pei "cat compose.yaml"
}

function addRepositoryAndController {
  displayMessage "Adding in Customer record, repository and controller"
  pei "cp -R $SCRIPTPATH/resources/project-overlay/customer/* ."
}

function startSpringBootClean {
  startSpringBoot clean
}

function testCustomerRepo {
  displayMessage "Testing Customer Repo"
  pei "http http://localhost:8080/customers"
}

function addGraphQL {
  displayMessage "Add GraphQL Query"
  pei "cp -R $SCRIPTPATH/resources/project-overlay/graphql/* ."
}

function testGraphQL {
  displayMessage "Test GraphQL query"
  pei "http http://localhost:8080/graphql operationName=MyQuery 'query=query MyQuery { customersByName(name:\"josh\") { id , name } }'"
}

function springBootStop {
  displayMessage "Stop the Spring Boot application"
  pei "./mvnw spring-boot:stop -Dspring-boot.stop.fork"
}

function startSpringBoot() {
  displayMessage "Start the Spring Boot application"
  pei "./mvnw -q $1 package spring-boot:start -DskipTests"
}

function addActivity {
  displayMessage "Add Activity Attribute"
  pei "cp -R $SCRIPTPATH/resources/project-overlay/activity/* ."
}

function testActivity {
  displayMessage "Test GraphQL query"
  pei "http http://localhost:8080/graphql operationName=MyQuery 'query=query MyQuery { customersByName(name:\"josh\") { id , name , suggestedActivity { activity, participants } } }'"
}

function addActuators {
  displayMessage "Add Actuators"
  pei "cp -R $SCRIPTPATH/resources/project-overlay/actuators/* ."
}

function testActuators {
  displayMessage "Test Actuators"
  pei "http http://localhost:8080/actuator/health"
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
addComposeItems
talkingPoint
addRepositoryAndController
talkingPoint
startSpringBootClean
talkingPoint
testCustomerRepo
talkingPoint
springBootStop
talkingPoint
addGraphQL
talkingPoint
startSpringBoot
talkingPoint
testGraphQL
talkingPoint
springBootStop
talkingPoint
addActivity
talkingPoint
startSpringBoot
talkingPoint
testActivity
talkingPoint
springBootStop
talkingPoint
addActuators
talkingPoint
startSpringBoot
testActuators
talkingPoint
springBootStop