#!/bin/bash
set -e

# MariaDBサービスを起動
mysqld_safe &

# MariaDBの起動を待つ
sleep 10

# rootパスワードの設定と認証プラグインの変更
# rootユーザーがlocalhostと%からアクセスできるようにする
mysql -uroot <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# WordPressデータベースの作成
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};"

# WordPressユーザーの作成と権限の付与
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "MariaDB setup completed."

# バックグラウンドで実行されているMariaDBプロセスを終了
pkill mysqld

# スクリプトの終了を待つ
wait

echo "Init script completed. Starting MariaDB server."