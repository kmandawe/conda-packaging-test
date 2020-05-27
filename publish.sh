#!/bin/bash
set -e

PROJECT_NAME=cpt
PROJECT_VERSION=$(<VERSION)
# shellcheck disable=SC2001
MAVEN_VERSION=$(echo "${PROJECT_VERSION%+*}" | sed 's/^[a-zA-Z]*//g')-SNAPSHOT
GROUP_ID=com.cheetahdigital.rse
RELEASES_URL="${NEXUS_RELEASES:=http://localhost:8081/repository/maven-releases}"
SNAPSHOTS_URL="${NEXUS_SNAPSHOTS:=http://localhost:8081/repository/maven-snapshots}"
NEXUS_URL=$SNAPSHOTS_URL
REPOSITORY_ID=nexus
SETTINGS_XML=~/.m2/settings.xml
OTHER_ARGUMENTS=()

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -r|--release)
        NEXUS_URL=$RELEASES_URL
        echo "NEXUS_URL set to: $NEXUS_URL"
        shift # Remove --release from processing
        ;;
        -p|--project)
        PROJECT_NAME="$2"
        echo "PROJECT_NAME set to: $PROJECT_NAME"
        shift # Remove argument name from processing
        shift # Remove argument value from processing
        ;;
        -v|--version)
        PROJECT_VERSION="$2"
        echo "PROJECT_VERSION set to: $PROJECT_VERSION"
        shift # Remove argument name from processing
        shift # Remove argument value from processing
        ;;
        -s|--settings)
        SETTINGS_XML="$2"
        echo "SETTINGS_XML set to: $SETTINGS_XML"
        shift # Remove argument name from processing
        shift # Remove argument value from processing
        ;;
        -g|--group-id)
        GROUP_ID="$2"
        echo "GROUP_ID set to: $GROUP_ID"
        shift # Remove argument name from processing
        shift # Remove argument value from processing
        ;;
        -i|--repo-id)
        echo "$@"
        REPOSITORY_ID="$2"
        echo "REPOSITORY_ID set to: $REPOSITORY_ID"
        shift # Remove argument name from processing
        shift # Remove argument value from processing
        ;;
        *)
        if [ $# -gt 0 ] && [ "$arg" = "$1" ]
        then
          OTHER_ARGUMENTS+=("$1")
          shift # Remove generic argument from processing
        fi
        ;;
    esac
done
echo "HELLO WORLD"
echo "************************** Starting Publish for Project: $PROJECT_NAME Version: $PROJECT_VERSION **************"
mvn -s "$SETTINGS_XML" deploy:deploy-file -DgroupId="$GROUP_ID" -Dversion="$MAVEN_VERSION" -DartifactId="$PROJECT_NAME" -Dpackaging=tar.gz -Dfile="dist/$PROJECT_NAME-$PROJECT_VERSION.tar.gz" -Durl="$NEXUS_URL" -DrepositoryId="$REPOSITORY_ID"
echo "************************** Done Pulishing Artifact: $PROJECT_NAME-$PROJECT_VERSION.tar.gz *********************"