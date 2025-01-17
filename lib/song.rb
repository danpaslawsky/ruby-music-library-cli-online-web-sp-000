require 'pry'

class Song
    extend Concerns::Findable
    extend Persistable::ClassMethods
    include Persistable::InstanceMethods
    
    attr_accessor :name, :genre
    attr_reader :artist

    @@all = []

    def self.all
        @@all
    end
    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.new_from_filename(filename)
        parts = filename.split(" - ")
        artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")
    
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
    
        new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

end