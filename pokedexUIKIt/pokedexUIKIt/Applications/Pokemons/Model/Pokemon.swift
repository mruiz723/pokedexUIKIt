//
//  Pokemon.swift
//  pokedexUIKIt
//
//  Created by Marlon David Ruiz Arroyave on 11/03/21.
//

import Foundation

// MARK: - Pokemon

enum PokemonType: String, Decodable, CaseIterable, Identifiable {
    var id: String { rawValue }

    case fire = "Fire"
    case grass = "Grass"
    case water = "Water"
    case poison = "Poison"
    case flying = "Flying"
    case electric = "Electric"
    case bug = "Bug"
    case normal = "Normal"
    case fighting = "Fighting"
    case ice = "Ice"
    case ground = "Ground"
}

struct Pokemon: Codable {
    let abilities: [Ability]
    let baseExperience: Int //base_experience
    let forms: [NamedAPIResource]
    let gameIndices: [GameIndex] //game_indices
    let height: Int
    let heldItems: [HeldItem] //held_items
    let id: Int
    let isDefault: Bool // is_default
    let locationAreaEncounters: String // location_area_encounters
    let moves: [MoveResource]
    let name: String
    let order: Int
//    let pastTypes: [] Pending to find a pokemon that uses this field
    let species: NamedAPIResource
    let sprites: Sprite
    let stats: [StatResource]
    let types: [TypeResource]
    let weight: Int
}

extension Pokemon {
    func formattedNumber() -> String {
        String(format: "#%03d", arguments: [id])
    }

    func primaryType() -> String? {
        guard let primary = types.first else { return nil }
        return primary.type.name.capitalized
    }

    func secondaryType() -> String? {
        let index = 1
        guard index < types.count else { return nil }
        return types[index].type.name.capitalized
    }
}

// MARK: - Ability

struct Ability: Codable {
    let ability: NamedAPIResource
    let isHidden: Bool
    let slot: Int
}

// MARK: - GameIndex

struct GameIndex: Codable {
    let gameIndex: Int
    let version: NamedAPIResource
}

// MARK: - HeldItem

struct HeldItem: Codable {
    let item: NamedAPIResource
    let versionDetails: [VersionDetail]
}

struct VersionDetail: Codable {
    let rarity: Int
    let version: NamedAPIResource
}

// MARK: - MoveResource

struct MoveResource: Codable {
    let move: NamedAPIResource
    let versionGroupDetails: [VersionGroupDetail] // version_group_details
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int // level_learned_at
    let moveLearnMethod: NamedAPIResource // move_learn_method
    let versionGroup: NamedAPIResource // version_group
}

// MARK: - Sprite

struct Sprite: Codable {
    let other: Other
}

struct Other: Codable {
    let dreamWorld: DreamWorld // dream_world
    let officialArtwork: OfficialArtwork // official-artwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case dreamWorld
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        officialArtwork = try container.decode(OfficialArtwork.self, forKey: .officialArtwork)
        dreamWorld = try container.decode(DreamWorld.self, forKey: .dreamWorld)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(officialArtwork, forKey: .officialArtwork)
        try container.encode(dreamWorld, forKey: .dreamWorld)
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String // front_default
}

struct DreamWorld: Codable {
    let frontDefault: String
    let frontFemale: String? // front_female
}

// MARK: - StatResource

struct StatResource: Codable {
    let baseStat: Int //base_stat
    let effort: Int
    let stat: NamedAPIResource
}

// MARK: - TypeResource

struct TypeResource: Codable {
    let slot: Int
    let type: NamedAPIResource
}
