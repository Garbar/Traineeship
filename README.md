== README

Нужно сделать приложение, в котором юзеры могли бы регистрироваться, логиниться и добавлять продукты.
Для регистрации нужны имя, email, пароль
У продукта есть название, описание и фотка.
Должна быть страничка со списком всех продуктов и возможностью просмотреть отдельный продукт.

Добавим немного псевдоинтерактива: Случилось прекрасное, ваше приложение посмотрел "заказчик", и понял, что надо кое-что переделать. Теперь у нас появляются разные типы юзеров:

### Администраторы
 * При регистрации должны указать имя, фамилию, email, пароль не короче 10 символов, аватарку, фото паспорта, дату рождения.
 * Могут помечать некоторые продукты как PRO.

### Владельцы магазинов
 * При регистрации должны указать название магазина, email, пароль не короче 8 символов, аватарку.
 * Могут добавлять товары.
 * У продукта появляется поле "название магазина". Значение автоматически копируется из профиля юзера. Нередактируемое поле.

### Гости
* Для регистрации должны ввести email и пароль не короче 6 символов.
* Не могут добавлять товары.
* После регистрации могут видеть товары помеченные как PRO.
* Не могут видеть название магазина в описании товара


