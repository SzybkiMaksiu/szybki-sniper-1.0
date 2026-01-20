echo Pobieranie plikow...
curl -L -o gradlew.bat "https://raw.githubusercontent.com/michalczewski/mc-files/main/gradlew.bat"
curl -L -o gradlew "https://raw.githubusercontent.com/michalczewski/mc-files/main/gradlew"
mkdir gradle\wrapper
curl -L -o gradle\wrapper\gradle-wrapper.jar "https://github.com/michalczewski/mc-files/raw/main/gradle-wrapper.jar"
echo distributionBase=GRADLE_USER_HOME > gradle\wrapper\gradle-wrapper.properties
echo distributionPath=wrapper/dists >> gradle\wrapper\gradle-wrapper.properties
echo distributionUrl=https://services.gradle.org/distributions/gradle-8.7-bin.zip >> gradle\wrapper\gradle-wrapper.properties
echo zipStoreBase=GRADLE_USER_HOME >> gradle\wrapper\gradle-wrapper.properties
echo zipStorePath=wrapper/dists >> gradle\wrapper\gradle-wrapper.properties
echo Gotowe! Teraz uruchom: gradlew build
pause