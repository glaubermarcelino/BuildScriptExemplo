#!/bin/bash


# Verificando se SOLUTION_DIR foi informado
if [ -n "$1" ]
then
    SOLUTION_DIR=$1
else
    SOLUTION_DIR=$APPCENTER_SOURCE_DIRECTORY
fi


# Criando variáveis dos arquivos
MANIFEST=$SOLUTION_DIR/Droid/Properties/AndroidManifest.xml
INFO_PLIST=$SOLUTION_DIR/iOS/Info.plist
ENTITLEMENTS_PLIST=$SOLUTION_DIR/iOS/Entitlements.plist
APP_CONFIG=$SOLUTION_DIR/Core/AppConfig.cs
APP_XAML=$SOLUTION_DIR/Core/App.xaml
APP_INI=$SOLUTION_DIR/Build/app.ini


# Verificando se app.ini existe
if [ -e "$APP_INI" ]
then
    CLIENTE=$(cat $APP_INI | grep "CLIENTE = " | awk '{print $3}')
    API_URL=$(cat $APP_INI | grep "API_URL = " | awk '{print $3}')
    VERSION_NAME=$(cat $APP_INI | grep "VERSION_NAME = " | awk '{print $3}')
    APP_NAME=$(cat $APP_INI | grep "APP_NAME = " | awk '{{out=$3; for(i=4;i<=NF;i++){out=out" "$i}; print out}}')
    PACKAGE=$(cat $APP_INI | grep "PACKAGE = " | awk '{print $3}')
    APS_ENVIRONMENT=$(cat $APP_INI | grep "APS_ENVIRONMENT = " | awk '{print $3}')
    PRIMARY_COLOR=$(cat $APP_INI | grep "PRIMARY_COLOR = " | awk '{print $3}')  
fi


# Copiar imagens
cp $SOLUTION_DIR/Build/Clientes/$CLIENTE/Droid/Resources/drawable/*.png \
$SOLUTION_DIR/Droid/Resources/drawable/

cp $SOLUTION_DIR/Build/Clientes/$CLIENTE/Droid/Resources/drawable-hdpi/*.png \
$SOLUTION_DIR/Droid/Resources/drawable-hdpi/

cp $SOLUTION_DIR/Build/Clientes/$CLIENTE/iOS/Assets.xcassets/AppIcon.appiconset/*.png \
$SOLUTION_DIR/iOS/Assets.xcassets/AppIcon.appiconset/

cp $SOLUTION_DIR/Build/Clientes/$CLIENTE/iOS/Assets.xcassets/LaunchImage.launchimage/*.png  \
$SOLUTION_DIR/iOS/Assets.xcassets/LaunchImage.launchimage/

cp $SOLUTION_DIR/Build/Clientes/$CLIENTE/iOS/Resources/*.png \
$SOLUTION_DIR/iOS/Resources/


# Manifesto Android
sed -i '' 's/versionName="[0-9.]*"/versionName="'$VERSION_NAME'"/' $MANIFEST
sed -i '' 's/android:label="[a-zA-Zà-úÀ-Ú0-9 ]*"/android:label="'"$APP_NAME"'"/' $MANIFEST
sed -i '' 's/package="[a-z.]*"/package="'$PACKAGE'"/' $MANIFEST


# plist iOS
plutil -replace CFBundleIdentifier -string $PACKAGE $INFO_PLIST
plutil -replace CFBundleName -string $APP_NAME $INFO_PLIST
plutil -replace CFBundleShortVersionString -string $VERSION_NAME $INFO_PLIST
plutil -replace aps-environment -string $APS_ENVIRONMENT $ENTITLEMENTS_PLIST


# Constantes
sed -i '' 's#ApiUrl = "[a-z:./]*"#ApiUrl = "'$API_URL'"#' $APP_CONFIG


# Resource dictionary
sed -i '' 's/"PrimaryColor">[a-zA-Z0-9#]*</"PrimaryColor">'$PRIMARY_COLOR'</' $APP_XAML
