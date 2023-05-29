# SteamApp

<p align="center">

<img src="https://github.com/IHIierO/SteamApp/assets/108677019/394d06de-2b02-4928-9346-24b8840ed874" width="300" height="600">

</p>

<p align="center">
<img src="https://img.shields.io/badge/Swift-Version%205-lightgrey" alt="Swift Version">
<img src="https://img.shields.io/badge/Ios-Version%2015%2B-important" alt="Ios Version">
<img src="https://img.shields.io/badge/App-Version%201.0-informational" alt="App Version">
</p>

<p align="center">
<img src="https://komarev.com/ghpvc/?username=IHIierO&style=flat-square&color=blue" alt=""/>
</p>

## About

Что было сделано:

1) Главный экран со списком доступных игр

 - Имитация пагинации и загрузки из сети
 - Кэширование списка игр
 - Поиск игры по названию
 - Хэш таблица для ускорения поиска игр т.к. список игр состоит из более чем 164 тыс. элементов
 - Навигация к экрану с новостями по выбраной игре

2) Экран с новостями по игре

 - Список всех новостей по игре
 - Навигация к экрану выбраной новости

3) Экран с новостью

 - Если есть url с новостью, то открывается Safari
 - Если нет url, то открывается WebView с обработкой HTML контента, который приходит из запроса новости


## Developers

- [Artem Vorobev](https://gist.github.com/IHIierO)
