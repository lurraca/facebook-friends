module Facebook
  class Friend

    attr_accessor :name, :picture

    def initialize(data)
      @name = data["name"]
      @picture = data["picture"]["data"]["url"]
    end

  end
end