#!/bin/bash 

# Получаем параметр из аргументов командной строки 
param="$1" 

# Проверка на наличие параметра 
if [ -z "$param" ]; then 
    echo -e "\033[0;31mОшибка: укажите имя блока\033[0m" 
    exit 1 
fi 

# Формируем имя файла с паттерном "_<параметр>.scss" 
filename="_${param}.scss" 

# Путь к директории с файлами 
config_path="src/scss/blocks" 

# Пути к файлам 
path="$config_path/$filename" 
index_path="$config_path/_index.scss" 

# Строка для добавления в _index.scss с использованием @use 
use_line="@use '${param}' as *;" 

# Создаем директорию, если она не существует 
mkdir -p "$config_path" 

# Проверяем, существует ли файл 
if [ -f "$path" ]; then 
    echo -e "\033[0;31mФайл $path уже существует\033[0m" 
else 
    # Создаем файл с определением класса, импортируем mixins через @use 
    echo -e "@use '../mixins' as *;\n\n// Блок: ${param}\n.${param} {\n    \n}" > "$path" 

    # Добавляем @use в _index.scss, если его там еще нет 
    if [ ! -f "$index_path" ]; then 
        touch "$index_path" 
    fi 

    if ! grep -q "$use_line" "$index_path"; then 
        echo "$use_line" >> "$index_path" 
    fi 

    # Выводим сообщение о завершении работы 
    echo -e "\033[0;32mФайл $path создан, строка @use добавлена в $index_path\033[0m" 
fi