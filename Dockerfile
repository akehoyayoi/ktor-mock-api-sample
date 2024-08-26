# 1. KotlinとJDKがインストールされた公式Gradleイメージをベースにする
FROM gradle:7.6.0-jdk17 AS build

# 2. 作業ディレクトリを設定
WORKDIR /app

# 3. プロジェクトのGradleファイルとソースコードをコピー
COPY build.gradle.kts settings.gradle.kts gradle.properties /app/
COPY src /app/src

# 4. 依存関係をダウンロードしてアプリケーションをビルド
RUN gradle build --no-daemon

# 5. 実行用の軽量JREイメージをベースにする
FROM openjdk:17-jdk-slim

# 6. ビルド成果物をコピー
COPY --from=build /app/build/libs/*.jar /app/app.jar

# 7. コンテナ内でアプリケーションを実行するコマンドを指定
CMD ["java", "-jar", "/app/app.jar"]

# 8. アプリケーションがリッスンするポートを指定
EXPOSE 8080
