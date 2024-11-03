import Foundation

// swiftlint:disable line_length

public extension NSAttributedStringBuilder {

    /// The language code describes the code associated with a language.
    ///
    /// The identifier conforms to [UTS #35](https://unicode.org/reports/tr35/).
    /// This language code provides the functionality of [Locale.LanguageCode](https://developer.apple.com/documentation/foundation/locale/languagecode)
    /// and `NSAttributedString.Key`
    /// [languageIdentifier](https://developer.apple.com/documentation/foundation/nsattributedstring/key/3809904-languageidentifier).
    @frozen
    enum LanguageCode: String, Codable, Hashable, Sendable {

        case ainu = "ain"
        case albanian = "sq"
        case amharic = "am"
        case apacheWestern = "apw"
        case arabic = "ar"
        case armenian = "hy"
        case assamese = "as"
        case assyrian = "syr"
        case azerbaijani = "az"
        case bangla = "bn"
        case belarusian = "be"
        case bodo = "brx"
        case bulgarian = "bg"
        case burmese = "my"
        case cantonese = "yue"
        case catalan = "ca"
        case cherokee = "chr"
        case chinese = "zh"
        case croatian = "hr"
        case czech = "cs"
        case danish = "da"
        case dhivehi = "dv"
        case dogri = "doi"
        case dutch = "nl"
        case dzongkha = "dz"
        case english = "en"
        case estonian = "et"
        case faroese = "fo"
        case finnish = "fi"
        case french = "fr"
        case fula = "ff"
        case georgian = "ka"
        case german = "de"
        case greek = "el"
        case gujarati = "gu"
        case hawaiian = "haw"
        case hebrew = "he"
        case hindi = "hi"
        case hungarian = "hu"
        case icelandic = "is"
        case igbo = "ig"
        case indonesian = "id"
        case irish = "ga"
        case italian = "it"
        case japanese = "ja"
        case kannada = "kn"
        case kashmiri = "ks"
        case kazakh = "kk"
        case khmer = "km"
        case konkani = "kok"
        case korean = "ko"
        case kurdish = "ku"
        case kurdishSorani = "ckb"
        case kyrgyz = "ky"
        case lao = "lo"
        case latvian = "lv"
        case lithuanian = "lt"
        case macedonian = "mk"
        case maithili = "mai"
        case malay = "ms"
        case malayalam = "ml"
        case maltese = "mt"
        case manipuri = "mni"
        case marathi = "mr"
        case mongolian = "mn"
        case māori = "mi"
        case navajo = "nv"
        case nepali = "ne"
        case norwegian = "no"
        case norwegianBokmål = "nb"
        case norwegianNynorsk = "nn"
        case odia = "or"
        case pashto = "ps"
        case persian = "fa"
        case polish = "pl"
        case portuguese = "pt"
        case rohingya = "rhg"
        case romanian = "ro"
        case russian = "ru"
        case samoan = "sm"
        case sanskrit = "sa"
        case santali = "sat"
        case serbian = "sr"
        case sindhi = "sd"
        case sinhala = "si"
        case slovak = "sk"
        case slovenian = "sl"
        case spanish = "es"
        case swahili = "sw"
        case swedish = "sv"
        case tagalog = "tl"
        case tajik = "tg"
        case tamil = "ta"
        case telugu = "te"
        case thai = "th"
        case tibetan = "bo"
        case tongan = "to"
        case turkish = "tr"
        case turkmen = "tk"
        case ukrainian = "uk"
        case urdu = "ur"
        case uyghur = "ug"
        case uzbek = "uz"
        case vietnamese = "vi"
        case welsh = "cy"
        case yiddish = "yi"

        case multiple = "mul"
        case unavailable = "zxx"
        case uncoded = "mis"
        case unidentified = "und"
        case unknown
    }
}

extension NSAttributedStringBuilder.LanguageCode: ExpressibleByStringLiteral {

    /// Initializes the `LanguageCode` with the language code string.
    /// - Parameters:
    ///   - value: The language code as string. Unknown codes are mapped to `unknown`.
    public init(stringLiteral value: StringLiteralType) {
        self = NSAttributedStringBuilder.LanguageCode(rawValue: value) ?? .unknown
    }
}

// swiftlint:enable line_length
