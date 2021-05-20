import { ID } from "@directus/sdk"

export type BookTranslation = {
    id: ID,
    date_created: string,
    date_updated: string,
    status: string,
    user_created: string,
    user_updated: string,
    config: string[]
    language: string,
    title: string,
}

export type Book = {
    id: ID,
    date_created: string,
    date_updated: string,
    status: string,
    user_created: string,
    user_updated: string,
    title: string,
    translations: number[]
}

export type ZulaMap = {
    book: Book,
    translation: BookTranslation
}