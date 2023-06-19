Config = {}

--[[
    TODO:
        * Але, администрация?
        * Сколько, ты зарабатываешь?

        * Бустер (пенис. осуждаю)
        * Стримерша Карина. (Сложна, сложна)
        * Тиктокерша Карина. (Фразочки)
        * Киселев. Совпадение? Не думаю.

        * Паша техник

        * Фразы из батлов (например, считалка оксимирона)

		* Звуковые фрагменты + анимации (в будущем)
		
        * Сделать так, чтобы если игрок стоял AFK, то он начинал делать какие то анимации и петь
        https://wiki.multitheftauto.com/index.php?title=RU/getSFXStatus
        https://wiki.multitheftauto.com/wiki/PlaySFX3D
]]

Config.sounds = {
    ['Фразы'] = {
        { name = 'Чё за суета?', src = 'assets/reactions/phrase_ru/voice_1.wav' },
        { name = 'Машина рывок имеет!', src = 'assets/reactions/phrase_ru/voice_2.wav' },
        { name = 'Это не лайба, это хулиганка.', src = 'assets/reactions/phrase_ru/voice_3.wav' },
        
        { name = 'Вставай за*бал, *баный шашлык!', src = 'assets/reactions/phrase_ru/voice_4.mp3' },
        { name = 'Почему так часто пропадаешь?', src = 'assets/reactions/phrase_ru/voice_5.mp3' },
        { name = 'Бл*ть, Ярик!', src = 'assets/reactions/phrase_ru/voice_6.mp3' },
        { name = 'Бан бл*ть!', src = 'assets/reactions/phrase_ru/voice_7.mp3' },
        { name = 'Да ты за*бал.', src = 'assets/reactions/phrase_ru/voice_8.mp3' },
        { name = 'Них*я себе O_o', src = 'assets/reactions/phrase_ru/voice_9.mp3' },
        
        { name = 'Опа, кого то хлопнули O_o', src = 'assets/reactions/phrase_ru/voice_11.wav' },
        { name = 'Повезло-повезло.', src = 'assets/reactions/phrase_ru/voice_12.wav' },
        { name = 'Ара, ты чо? O_o', src = 'assets/reactions/phrase_ru/voice_13.mp3' },
        { name = 'Быстро, бл*ть!', src = 'assets/reactions/phrase_ru/voice_14.ogg' },
        { name = 'Братишка, братишка.', src = 'assets/reactions/phrase_ru/voice_15.ogg' },
        { name = '*баное казино!', src = 'assets/reactions/phrase_ru/voice_16.ogg' },
        { name = 'Так алё, я не понял. Это чо? O_o', src = 'assets/reactions/phrase_ru/voice_17.ogg' },
        { name = 'Чики брики в дамки.', src = 'assets/reactions/phrase_ru/voice_18.ogg' },

        { name = 'Иди на х*й г*ндон! (дед)', src = 'assets/reactions/phrase_ru/voice_19.ogg' },
        { name = 'На! Будешь с*с*ть? (дед)', src = 'assets/reactions/phrase_ru/voice_20.ogg' },
        { name = 'Я убью! Я их в рот *бал. (дед)', src = 'assets/reactions/phrase_ru/voice_21.ogg' },
        { name = 'Ты? Меня так послал.. (дед)', src = 'assets/reactions/phrase_ru/voice_22.ogg' },

        { name = 'Пошел ты нахер, козёл!', src = 'assets/reactions/phrase_ru/voice_23.ogg' },
        { name = 'Ну накажите!', src = 'assets/reactions/phrase_ru/voice_24.ogg' },

        { name = 'Вам всем п*здец!', src = 'assets/reactions/phrase_ru/voice_25.ogg' },
        { name = 'Это была шутка!', src = 'assets/reactions/phrase_ru/voice_26.ogg' },
        { name = 'Свали от сюда бл*ть!', src = 'assets/reactions/phrase_ru/voice_27.ogg' },

        { name = 'Ты кто такой?', src = 'assets/reactions/phrase_ru/voice_28.ogg' },
        { name = 'Звучит правдаподобно.', src = 'assets/reactions/phrase_ru/voice_29.ogg' },
        { name = 'Жри патрон!', src = 'assets/reactions/phrase_ru/voice_30.ogg' },
    },

    ['Да/Нет'] = {
        { name = 'Yes, yes, yes!', src = 'assets/reactions/yes_no/voice_1.ogg' },
        { name = 'No!', src = 'assets/reactions/yes_no/voice_2.ogg' },
        { name = 'No!', src = 'assets/reactions/yes_no/voice_3.ogg' },
        { name = 'No!', src = 'assets/reactions/yes_no/voice_4.ogg' },
        { name = 'Yes!', src = 'assets/reactions/yes_no/voice_5.ogg' },
    },

    ['Приветствие'] = {
        { name = 'Здарова, за*бал ;)', src = 'assets/reactions/hallo/voice_hallo_1.mp3' },
        { name = 'Здрастити!', src = 'assets/reactions/hallo/voice_hallo_2.ogg'},
        { name = 'Привет, придурки!', src = 'assets/reactions/hallo/voice_hallo_3.wav'},
    },

    ['Эмоции'] = {
        { name = 'А-а-а-а-а-а-а!!!', src = 'assets/reactions/emotion/voice_emotion_1.ogg' },
        { name = 'А-а-а-а-а-а-а!!!', src = 'assets/reactions/emotion/voice_emotion_2.ogg' },
        { name = 'А-а-а-а-а-а-а!!!', src = 'assets/reactions/emotion/voice_emotion_3.ogg' },
        { name = 'Чего бл*ть?', src = 'assets/reactions/emotion/voice_emotion_4.ogg' },
        { name = 'Ко-ко-ко-ко', src = 'assets/reactions/emotion/voice_emotion_5.ogg' },
        { name = 'Эмоция на немецком языке.', src = 'assets/reactions/emotion/voice_emotion_6.mp3' },
        { name = 'На-а-а-а!', src = 'assets/reactions/emotion/voice_emotion_7.ogg' },

        { name = 'Бл************ть!', src = 'assets/reactions/emotion/voice_emotion_8.ogg' },
        { name = 'А-а-а-а, больно с*ка :(', src = 'assets/reactions/emotion/voice_emotion_9.ogg' },
    },

    ['Фразы (английские)'] = {
        { name = 'Oh shit!', src = 'assets/reactions/phrase_en/voice_en_1.ogg' },
        { name = 'Ryder Nigga!', src = 'assets/reactions/phrase_en/voice_en_2.wav' },
        { name = 'Wrong house!', src = 'assets/reactions/phrase_en/voice_en_3.ogg' },
        { name = 'Shut the Fuck up!', src = 'assets/reactions/phrase_en/voice_en_4.mp3' },
        { name = 'Sir, yes sir!', src = 'assets/reactions/phrase_en/voice_en_5.ogg' },
        { name = 'Time to stop!', src = 'assets/reactions/phrase_en/voice_en_6.mp3' },
        { name = 'Was follow the damn train CJ!', src = 'assets/reactions/phrase_en/voice_en_7.ogg' },
        { name = 'Shut up!', src = 'assets/reactions/phrase_en/voice_en_8.wav' },
    },

    ['Смех'] = {
        { name = 'Смех №1', src = 'assets/reactions/laugh/voice_laugh_1.mp3' },
        { name = 'Смех №2', src = 'assets/reactions/laugh/voice_laugh_2.mp3' },
        { name = 'Смех №3', src = 'assets/reactions/laugh/voice_laugh_3.mp3' },
        { name = 'Смех №4', src = 'assets/reactions/laugh/voice_laugh_4.mp3' },
        { name = 'Смех №5', src = 'assets/reactions/laugh/voice_laugh_5.mp3' },
        { name = 'Смех №6', src = 'assets/reactions/laugh/voice_laugh_6.mp3' },
        { name = 'Смех №7', src = 'assets/reactions/laugh/voice_laugh_7.mp3' },
        { name = 'Смех №8', src = 'assets/reactions/laugh/voice_laugh_8.mp3' },
        { name = 'Смех №9', src = 'assets/reactions/laugh/voice_laugh_9.mp3' },
        { name = 'Смех №10', src = 'assets/reactions/laugh/voice_laugh_10.ogg' },
        { name = 'Смех №11', src = 'assets/reactions/laugh/voice_laugh_11.ogg' },
        { name = 'Смех №12', src = 'assets/reactions/laugh/voice_laugh_12.ogg' },
        { name = 'Смех №13', src = 'assets/reactions/laugh/voice_laugh_13.wav' },
        { name = 'Смех №14', src = 'assets/reactions/laugh/voice_laugh_14.wav' },
        { name = 'Смех №15', src = 'assets/reactions/laugh/voice_laugh_15.wav' },
        { name = 'Смех №16', src = 'assets/reactions/laugh/voice_laugh_16.wav' },
        { name = 'Смех №17', src = 'assets/reactions/laugh/voice_laugh_17.wav' },
        { name = 'Смех №18', src = 'assets/reactions/laugh/voice_laugh_18.wav' },
    },

    ['Опасный поцик'] = {
        { name = 'Это наша точка!', src = 'assets/reactions/potsyk/voice_1.wav' },
        { name = 'Урод, бл*ть', src = 'assets/reactions/potsyk/voice_2.wav' },
        { name = 'У*бок', src = 'assets/reactions/potsyk/voice_3.wav' },
        { name = 'Ты, урод, бл*ть!', src = 'assets/reactions/potsyk/voice_4.wav' },
        { name = 'Ты, у*бок!', src = 'assets/reactions/potsyk/voice_5.wav' },
        { name = 'Ты, п*др бл*ть!', src = 'assets/reactions/potsyk/voice_6.wav' },
        { name = 'П*зды дал!', src = 'assets/reactions/potsyk/voice_7.wav' },
        { name = 'П*др бл*ть!', src = 'assets/reactions/potsyk/voice_8.wav' },
        { name = 'Ты на пенёк сел..', src = 'assets/reactions/potsyk/voice_9.wav' },
        { name = 'Ммм?', src = 'assets/reactions/potsyk/voice_10.wav' },
        { name = 'Как у*бу, с*ка!', src = 'assets/reactions/potsyk/voice_11.wav' },
        { name = 'Иди нах*й п*др бл*ть!', src = 'assets/reactions/potsyk/voice_12.wav' },
        { name = 'Иди нах*й урод бл*!', src = 'assets/reactions/potsyk/voice_13.wav' },
        { name = 'Иди нах*й у*ба!', src = 'assets/reactions/potsyk/voice_14.wav' },
    },

    ['Без категории'] = {
        { name = 'Nani?', src = 'assets/reactions/other/voice_other_1.ogg' },
        { name = 'Вот это поворот!', src = 'assets/reactions/other/voice_other_2.ogg' },
        { name = 'Ну нахер.', src = 'assets/reactions/other/voice_other_3.ogg' },
        { name = '*тьфу* На те в еб*ло бл*ть!', src = 'assets/reactions/other/voice_other_4.ogg' },
        { name = 'Дело-сделано.', src = 'assets/reactions/other/voice_other_5.ogg' },
        { name = '*лай собаки*', src = 'assets/reactions/other/voice_other_6.ogg' },
        { name = 'Иди своей дорогой! Сталкер.', src = 'assets/reactions/other/voice_other_7.ogg' },
        { name = 'Easy, easy! Real talk. Think about it.', src = 'assets/reactions/other/voice_other_8.ogg' },
        { name = 'Боже мой. Да всем насрать!', src = 'assets/reactions/other/voice_other_9.ogg' },
        { name = 'Великолепный план!', src = 'assets/reactions/other/voice_other_10.ogg' },
        { name = 'Ублюдок, мать твою. А ну иди сюда..', src = 'assets/reactions/other/voice_other_11.ogg' },
        { name = '*возглас петуха*', src = 'assets/reactions/other/voice_other_12.ogg' },
    }

}

Config.default_sound = Config.sounds['Фразы'][1].src -- звук по умолчанию
Config.key = 'X'