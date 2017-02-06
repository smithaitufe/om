rule = "-------------------------------------------------------------------------------------------------";

import Ecto.Query
alias Store.{Repo, Country, ItemType, TaxRate, OrderStatus, OrderState, ShippingZone, State, LocalGovernmentArea, InvoiceType, InvoiceStatus, ProductCategory, Brand, UserType, User, Shop, Product, Variant, ShippingCategory, City, Cart, CartItem, Address, OptionGroup, Option}
alias Store.{Property, Prototype, PrototypeProperty, Image, ImageGroup, ProductImage}

get_user_type = fn code -> Repo.get_by(UserType, code: code) end
get_product_category = fn name -> Repo.get_by(ProductCategory, [name: name]) end
save_product_category = fn product_categories ->
  Enum.each(product_categories,
    fn product_category ->
      Repo.get_by(ProductCategory, name: product_category[:name])
      |> case do
          nil -> ProductCategory.changeset(%ProductCategory{}, product_category) |> Repo.insert!
          _ -> IO.inspect "Not inserted due to duplication"
        end
  end
  )
end





country  = Repo.get_by(Country, [name: "Nigeria"])
if country == nil do
  %Country{}
  |> Country.changeset(%{name: "Nigeria", abbreviation: "NG"})
  |> Repo.insert!()
end
[%{name: "Nation Wide"},%{name: "Area Wide"}]
|> Enum.each(fn shipping_zone ->
    Repo.get_by(ShippingZone, name: shipping_zone[:name])
    |> case do
      nil ->
      %ShippingZone{}
      |> ShippingZone.changeset(shipping_zone)
      |> Repo.insert!()
      _ -> IO.inspect "Existing already"
    end
end)

country  = Repo.get_by(Country, [name: "Nigeria"])
case Repo.get_by(TaxRate,  [country_id: country.id, percentage: 5]) do
  nil ->
    TaxRate.changeset(%TaxRate{}, %{country_id: country.id, percentage: 5, start_date: DateTime.utc_now}) |> Repo.insert!()
    _ -> IO.inspect "Existing"
end

[
  %{name: "Open"},
  %{name: "Processed"},
  %{name: "Failed"},
  %{name: "Completed"},
  %{name: "Cancelled"},
  %{name: "Declined"},
  %{name: "Backordered"}
]
|> Enum.each(fn order_status ->
  case Repo.get_by(OrderStatus, name: order_status[:name]) do
    nil ->  OrderStatus.changeset(%OrderStatus{}, order_status) |> Repo.insert!()
    _ -> IO.inspect "Existing"
  end
end )

[%{name: "shopping_cart", description: "Shopping Cart"},%{name: "save_for_later", description: "Save for later"},%{name: "wish_list", description: "Wish List"}, %{name: "purchased", description: "Purchased"}]
|> Enum.each(fn item_type ->
  Repo.get_by(ItemType, [name: item_type[:name]])
  |> case do
      nil -> ItemType.changeset(%ItemType{}, item_type) |> Repo.insert!
      _ -> IO.inspect "Existing already"
    end
end)


country = Country |> Repo.get_by(name: "Nigeria")
[
  %{name: "Abia", shipping_zone_id: 1},
  %{name: "Adamawa", shipping_zone_id: 1},
  %{name: "Akwa Ibom", shipping_zone_id: 1},
  %{name: "Anambra", shipping_zone_id: 2},
  %{name: "Bauchi", shipping_zone_id: 1},
  %{name: "Bayelsa", shipping_zone_id: 1},
  %{name: "Benue", shipping_zone_id: 1},
  %{name: "Bornu", shipping_zone_id: 1},
  %{name: "Cross River", shipping_zone_id: 1},
  %{name: "Delta", shipping_zone_id: 2},
  %{name: "Ebonyi", shipping_zone_id: 1},
  %{name: "Edo", shipping_zone_id: 1},
  %{name: "Ekiti", shipping_zone_id: 1},
  %{name: "Enugu", shipping_zone_id: 1},
  %{name: "FCT", shipping_zone_id: 1},
  %{name: "Gombe", shipping_zone_id: 1},
  %{name: "Imo", shipping_zone_id: 2},
  %{name: "Jigawa", shipping_zone_id: 1},
  %{name: "Kaduna", shipping_zone_id: 1},
  %{name: "Kano", shipping_zone_id: 1},
  %{name: "Katsina", shipping_zone_id: 1},
  %{name: "Kebbi", shipping_zone_id: 1},
  %{name: "Kogi", shipping_zone_id: 1},
  %{name: "Kwara", shipping_zone_id: 1},
  %{name: "Lagos", shipping_zone_id: 1},
  %{name: "Nasarawa", shipping_zone_id: 1},
  %{name: "Niger", shipping_zone_id: 1},
  %{name: "Ogun", shipping_zone_id: 1},
  %{name: "Ondo", shipping_zone_id: 1},
  %{name: "Osun", shipping_zone_id: 1},
  %{name: "Oyo", shipping_zone_id: 1},
  %{name: "Plateau", shipping_zone_id: 1},
  %{name: "Rivers", shipping_zone_id: 1},
  %{name: "Sokoto", shipping_zone_id: 1},
  %{name: "Taraba", shipping_zone_id: 1},
  %{name: "Yobe", shipping_zone_id: 1},
  %{name: "Zamfara", shipping_zone_id: 1}
]
|> Enum.each(fn state ->
  Repo.transaction fn ->
    State
    |> Repo.get_by([country_id: country.id, name: state[:name]])
    |> case do
        nil -> State.changeset(%State{}, Map.put(state, :country_id, country.id)) |> Repo.insert!
        country -> IO.inspect "found"
      end
  end
end)

[
  %{name: "Aba North", state: "Abia"},
  %{name: "Aba South", state: "Abia"},
  %{name: "Arochukwu", state: "Abia"},
  %{name: "Bende", state: "Abia"},
  %{name: "Ikwuano", state: "Abia"},
  %{name: "Isiala-Ngwa North", state: "Abia"},
  %{name: "Isiala-Ngwa South", state: "Abia"},
  %{name: "Isuikwato", state: "Abia"},
  %{name: "Obi Nwa", state: "Abia"},
  %{name: "Ohafia", state: "Abia"},
  %{name: "Osisioma", state: "Abia"},
  %{name: "Ngwa", state: "Abia"},
  %{name: "Ugwunagbo", state: "Abia"},
  %{name: "Ukwa East", state: "Abia"},
  %{name: "Ukwa West", state: "Abia"},
  %{name: "Umuahia North", state: "Abia"},
  %{name: "Umuahia South", state: "Abia"},
  %{name: "Umu-Neochi", state: "Abia"},
  %{name: "Demsa", state: "Adamawa"},
  %{name: "Fufore", state: "Adamawa"},
  %{name: "Ganaye", state: "Adamawa"},
  %{name: "Gireri", state: "Adamawa"},
  %{name: "Gombi", state: "Adamawa"},
  %{name: "Guyuk", state: "Adamawa"},
  %{name: "Hong", state: "Adamawa"},
  %{name: "Jada", state: "Adamawa"},
  %{name: "Lamurde", state: "Adamawa"},
  %{name: "Madagali", state: "Adamawa"},
  %{name: "Maiha", state: "Adamawa"},
  %{name: "Mayo-Belwa", state: "Adamawa"},
  %{name: "Michika", state: "Adamawa"},
  %{name: "Mubi North", state: "Adamawa"},
  %{name: "Mubi South", state: "Adamawa"},
  %{name: "Numan", state: "Adamawa"},
  %{name: "Shelleng", state: "Adamawa"},
  %{name: "Song", state: "Adamawa"},
  %{name: "Toungo", state: "Adamawa"},
  %{name: "Yola North", state: "Adamawa"},
  %{name: "Yola South", state: "Adamawa"},
  %{name: "Abak", state: "Akwa Ibom"},
  %{name: "Eastern Obolo", state: "Akwa Ibom"},
  %{name: "Eket", state: "Akwa Ibom"},
  %{name: "Esit Eket", state: "Akwa Ibom"},
  %{name: "Essien Udim", state: "Akwa Ibom"},
  %{name: "Etim Ekpo", state: "Akwa Ibom"},
  %{name: "Etinan", state: "Akwa Ibom"},
  %{name: "Ibeno", state: "Akwa Ibom"},
  %{name: "Ibesikpo Asutan", state: "Akwa Ibom"},
  %{name: "Ibiono Ibom", state: "Akwa Ibom"},
  %{name: "Ika", state: "Akwa Ibom"},
  %{name: "Ikono", state: "Akwa Ibom"},
  %{name: "Ikot Abasi", state: "Akwa Ibom"},
  %{name: "Ikot Ekpene", state: "Akwa Ibom"},
  %{name: "Ini", state: "Akwa Ibom"},
  %{name: "Itu", state: "Akwa Ibom"},
  %{name: "Mbo", state: "Akwa Ibom"},
  %{name: "Mkpat Enin", state: "Akwa Ibom"},
  %{name: "Nsit Atai", state: "Akwa Ibom"},
  %{name: "Nsit Ibom", state: "Akwa Ibom"},
  %{name: "Nsit Ubium", state: "Akwa Ibom"},
  %{name: "Obot Akara", state: "Akwa Ibom"},
  %{name: "Okobo", state: "Akwa Ibom"},
  %{name: "Onna", state: "Akwa Ibom"},
  %{name: "Oron", state: "Akwa Ibom"},
  %{name: "Oruk Anam", state: "Akwa Ibom"},
  %{name: "Udung Uko", state: "Akwa Ibom"},
  %{name: "Ukanafun", state: "Akwa Ibom"},
  %{name: "Uruan", state: "Akwa Ibom"},
  %{name: "Urue-Offong/Oruko", state: "Akwa Ibom"},
  %{name: "Uyo", state: "Akwa Ibom"},
  %{name: "Aguata", state: "Anambra"},
  %{name: "Anambra East", state: "Anambra"},
  %{name: "Anambra West", state: "Anambra"},
  %{name: "Anaocha", state: "Anambra"},
  %{name: "Awka North", state: "Anambra"},
  %{name: "Awka South", state: "Anambra"},
  %{name: "Ayamelum", state: "Anambra"},
  %{name: "Dunukofia", state: "Anambra"},
  %{name: "Ekwusigo", state: "Anambra"},
  %{name: "Idemili North", state: "Anambra"},
  %{name: "Idemili south", state: "Anambra"},
  %{name: "Ihiala", state: "Anambra"},
  %{name: "Njikoka", state: "Anambra"},
  %{name: "Nnewi North", state: "Anambra"},
  %{name: "Nnewi South", state: "Anambra"},
  %{name: "Ogbaru", state: "Anambra"},
  %{name: "Onitsha North", state: "Anambra"},
  %{name: "Onitsha South", state: "Anambra"},
  %{name: "Orumba North", state: "Anambra"},
  %{name: "Orumba South", state: "Anambra"},
  %{name: "Oyi", state: "Anambra"},
  %{name: "Alkaleri", state: "Bauchi"},
  %{name: "Bauchi", state: "Bauchi"},
  %{name: "Bogoro", state: "Bauchi"},
  %{name: "Damban", state: "Bauchi"},
  %{name: "Darazo", state: "Bauchi"},
  %{name: "Dass", state: "Bauchi"},
  %{name: "Ganjuwa", state: "Bauchi"},
  %{name: "Giade", state: "Bauchi"},
  %{name: "Itas/Gadau", state: "Bauchi"},
  %{name: "Jama'are", state: "Bauchi"},
  %{name: "Katagum", state: "Bauchi"},
  %{name: "Kirfi", state: "Bauchi"},
  %{name: "Misau", state: "Bauchi"},
  %{name: "Ningi", state: "Bauchi"},
  %{name: "Shira", state: "Bauchi"},
  %{name: "Tafawa-Balewa", state: "Bauchi"},
  %{name: "Toro", state: "Bauchi"},
  %{name: "Warji", state: "Bauchi"},
  %{name: "Zaki", state: "Bauchi"},
  %{name: "Brass", state: "Bayelsa"},
  %{name: "Ekeremor", state: "Bayelsa"},
  %{name: "Kolokuma/Opokuma", state: "Bayelsa"},
  %{name: "Nembe", state: "Bayelsa"},
  %{name: "Ogbia", state: "Bayelsa"},
  %{name: "Sagbama", state: "Bayelsa"},
  %{name: "Southern Jaw", state: "Bayelsa"},
  %{name: "Yenegoa", state: "Bayelsa"},
  %{name: "Ado", state: "Benue"},
  %{name: "Agatu", state: "Benue"},
  %{name: "Apa", state: "Benue"},
  %{name: "Buruku", state: "Benue"},
  %{name: "Gboko", state: "Benue"},
  %{name: "Guma", state: "Benue"},
  %{name: "Gwer East", state: "Benue"},
  %{name: "Gwer West", state: "Benue"},
  %{name: "Katsina-Ala", state: "Benue"},
  %{name: "Konshisha", state: "Benue"},
  %{name: "Kwande", state: "Benue"},
  %{name: "Logo", state: "Benue"},
  %{name: "Makurdi", state: "Benue"},
  %{name: "Obi", state: "Benue"},
  %{name: "Ogbadibo", state: "Benue"},
  %{name: "Oju", state: "Benue"},
  %{name: "Okpokwu", state: "Benue"},
  %{name: "Ohimini", state: "Benue"},
  %{name: "Oturkpo", state: "Benue"},
  %{name: "Tarka", state: "Benue"},
  %{name: "Ukum", state: "Benue"},
  %{name: "Ushongo", state: "Benue"},
  %{name: "Vandeikya", state: "Benue"},
  %{name: "Abadam", state: "Bornu"},
  %{name: "Askira/Uba", state: "Bornu"},
  %{name: "Bama", state: "Bornu"},
  %{name: "Bayo", state: "Bornu"},
  %{name: "Biu", state: "Bornu"},
  %{name: "Chibok", state: "Bornu"},
  %{name: "Damboa", state: "Bornu"},
  %{name: "Dikwa", state: "Bornu"},
  %{name: "Gubio", state: "Bornu"},
  %{name: "Guzamala", state: "Bornu"},
  %{name: "Gwoza", state: "Bornu"},
  %{name: "Hawul", state: "Bornu"},
  %{name: "Jere", state: "Bornu"},
  %{name: "Kaga", state: "Bornu"},
  %{name: "Kala/Balge", state: "Bornu"},
  %{name: "Konduga", state: "Bornu"},
  %{name: "Kukawa", state: "Bornu"},
  %{name: "Kwaya Kusar", state: "Bornu"},
  %{name: "Mafa", state: "Bornu"},
  %{name: "Magumeri", state: "Bornu"},
  %{name: "Maiduguri", state: "Bornu"},
  %{name: "Marte", state: "Bornu"},
  %{name: "Mobbar", state: "Bornu"},
  %{name: "Monguno", state: "Bornu"},
  %{name: "Ngala", state: "Bornu"},
  %{name: "Nganzai", state: "Bornu"},
  %{name: "Shani", state: "Bornu"},
  %{name: "Akpabuyo", state: "Cross River"},
  %{name: "Odukpani", state: "Cross River"},
  %{name: "Akamkpa", state: "Cross River"},
  %{name: "Biase", state: "Cross River"},
  %{name: "Abi", state: "Cross River"},
  %{name: "Ikom", state: "Cross River"},
  %{name: "Yarkur", state: "Cross River"},
  %{name: "Odubra", state: "Cross River"},
  %{name: "Boki", state: "Cross River"},
  %{name: "Ogoja", state: "Cross River"},
  %{name: "Yala", state: "Cross River"},
  %{name: "Obanliku", state: "Cross River"},
  %{name: "Obudu", state: "Cross River"},
  %{name: "Calabar South", state: "Cross River"},
  %{name: "Etung", state: "Cross River"},
  %{name: "Bekwara", state: "Cross River"},
  %{name: "Bakassi", state: "Cross River"},
  %{name: "Calabar Municipality", state: "Cross River"},
  %{name: "Oshimili South", state: "Delta"},
  %{name: "Aniocha North", state: "Delta"},
  %{name: "Aniocha South", state: "Delta"},
  %{name: "Ika South", state: "Delta"},
  %{name: "Ika North-East", state: "Delta"},
  %{name: "Ndokwa West", state: "Delta"},
  %{name: "Ndokwa East", state: "Delta"},
  %{name: "Isoko South", state: "Delta"},
  %{name: "Isoko North", state: "Delta"},
  %{name: "Bomadi", state: "Delta"},
  %{name: "Burutu", state: "Delta"},
  %{name: "Ughelli South", state: "Delta"},
  %{name: "Ughelli North", state: "Delta"},
  %{name: "Ethiope West", state: "Delta"},
  %{name: "Ethiope East", state: "Delta"},
  %{name: "Sapele", state: "Delta"},
  %{name: "Okpe", state: "Delta"},
  %{name: "Warri North", state: "Delta"},
  %{name: "Warri South", state: "Delta"},
  %{name: "Uvwie", state: "Delta"},
  %{name: "Udu", state: "Delta"},
  %{name: "Warri Central", state: "Delta"},
  %{name: "Ukwani", state: "Delta"},
  %{name: "Oshimili North", state: "Delta"},
  %{name: "Patani", state: "Delta"},
  %{name: "Afikpo South", state: "Ebonyi"},
  %{name: "Afikpo North", state: "Ebonyi"},
  %{name: "Onicha", state: "Ebonyi"},
  %{name: "Ohaozara", state: "Ebonyi"},
  %{name: "Abakaliki", state: "Ebonyi"},
  %{name: "Ishielu", state: "Ebonyi"},
  %{name: "lkwo", state: "Ebonyi"},
  %{name: "Ezza", state: "Ebonyi"},
  %{name: "Ezza South", state: "Ebonyi"},
  %{name: "Ohaukwu", state: "Ebonyi"},
  %{name: "Ebonyi", state: "Ebonyi"},
  %{name: "Ivo", state: "Ebonyi"},
  %{name: "Esan North-East", state: "Edo"},
  %{name: "Esan Central", state: "Edo"},
  %{name: "Esan West", state: "Edo"},
  %{name: "Egor", state: "Edo"},
  %{name: "Ukpoba", state: "Edo"},
  %{name: "Central", state: "Edo"},
  %{name: "Etsako Central", state: "Edo"},
  %{name: "Igueben", state: "Edo"},
  %{name: "Oredo", state: "Edo"},
  %{name: "Ovia SouthWest", state: "Edo"},
  %{name: "Ovia South-East", state: "Edo"},
  %{name: "Orhionwon", state: "Edo"},
  %{name: "Uhunmwonde", state: "Edo"},
  %{name: "Etsako East", state: "Edo"},
  %{name: "Esan South-East", state: "Edo"},
  %{name: "Ado", state: "Ekiti"},
  %{name: "Ekiti-East", state: "Ekiti"},
  %{name: "Ekiti-West", state: "Ekiti"},
  %{name: "Emure/Ise/Orun", state: "Ekiti"},
  %{name: "Ekiti South-West", state: "Ekiti"},
  %{name: "Ikare", state: "Ekiti"},
  %{name: "Irepodun", state: "Ekiti"},
  %{name: "Ijero,", state: "Ekiti"},
  %{name: "Ido/Osi", state: "Ekiti"},
  %{name: "Oye", state: "Ekiti"},
  %{name: "Ikole", state: "Ekiti"},
  %{name: "Moba", state: "Ekiti"},
  %{name: "Gbonyin", state: "Ekiti"},
  %{name: "Efon", state: "Ekiti"},
  %{name: "Ise/Orun", state: "Ekiti"},
  %{name: "Ilejemeje", state: "Ekiti"},
  %{name: "Enugu South,", state: "Enugu"},
  %{name: "Igbo-Eze South", state: "Enugu"},
  %{name: "Enugu North", state: "Enugu"},
  %{name: "Nkanu", state: "Enugu"},
  %{name: "Udi Agwu", state: "Enugu"},
  %{name: "Oji-River", state: "Enugu"},
  %{name: "Ezeagu", state: "Enugu"},
  %{name: "IgboEze North", state: "Enugu"},
  %{name: "Isi-Uzo", state: "Enugu"},
  %{name: "Nsukka", state: "Enugu"},
  %{name: "Igbo-Ekiti", state: "Enugu"},
  %{name: "Uzo-Uwani", state: "Enugu"},
  %{name: "Enugu Eas", state: "Enugu"},
  %{name: "Aninri", state: "Enugu"},
  %{name: "Nkanu East", state: "Enugu"},
  %{name: "Udenu", state: "Enugu"},
  %{name: "Awgu", state: "Enugu"},
  %{name: "Gwagwalada", state: "FCT"},
  %{name: "Kuje", state: "FCT"},
  %{name: "Abaji", state: "FCT"},
  %{name: "Abuja Municipal", state: "FCT"},
  %{name: "Bwari", state: "FCT"},
  %{name: "Kwali", state: "FCT"},
  %{name: "Akko", state: "Gombe"},
  %{name: "Balanga", state: "Gombe"},
  %{name: "Billiri", state: "Gombe"},
  %{name: "Dukku", state: "Gombe"},
  %{name: "Kaltungo", state: "Gombe"},
  %{name: "Kwami", state: "Gombe"},
  %{name: "Shomgom", state: "Gombe"},
  %{name: "Funakaye", state: "Gombe"},
  %{name: "Gombe", state: "Gombe"},
  %{name: "Nafada/Bajoga", state: "Gombe"},
  %{name: "Yamaltu/Delta", state: "Gombe"},
  %{name: "Aboh-Mbaise", state: "Imo"},
  %{name: "Ahiazu-Mbaise", state: "Imo"},
  %{name: "Ehime-Mbano", state: "Imo"},
  %{name: "Ezinihitte", state: "Imo"},
  %{name: "Ideato North", state: "Imo"},
  %{name: "Ideato South", state: "Imo"},
  %{name: "Ihitte/Uboma", state: "Imo"},
  %{name: "Ikeduru", state: "Imo"},
  %{name: "Isiala Mbano", state: "Imo"},
  %{name: "Isu", state: "Imo"},
  %{name: "Mbaitoli", state: "Imo"},
  %{name: "Mbaitoli", state: "Imo"},
  %{name: "Ngor-Okpala", state: "Imo"},
  %{name: "Njaba", state: "Imo"},
  %{name: "Nwangele", state: "Imo"},
  %{name: "Nkwerre", state: "Imo"},
  %{name: "Obowo", state: "Imo"},
  %{name: "Oguta", state: "Imo"},
  %{name: "Ohaji/Egbema", state: "Imo"},
  %{name: "Okigwe", state: "Imo"},
  %{name: "Orlu", state: "Imo"},
  %{name: "Orsu", state: "Imo"},
  %{name: "Oru East", state: "Imo"},
  %{name: "Oru West", state: "Imo"},
  %{name: "Owerri-Municipal", state: "Imo"},
  %{name: "Owerri North", state: "Imo"},
  %{name: "Owerri West", state: "Imo"},
  %{name: "Auyo", state: "Jigawa"},
  %{name: "Babura", state: "Jigawa"},
  %{name: "Birni Kudu", state: "Jigawa"},
  %{name: "Biriniwa", state: "Jigawa"},
  %{name: "Buji", state: "Jigawa"},
  %{name: "Dutse", state: "Jigawa"},
  %{name: "Gagarawa", state: "Jigawa"},
  %{name: "Garki", state: "Jigawa"},
  %{name: "Gumel", state: "Jigawa"},
  %{name: "Guri", state: "Jigawa"},
  %{name: "Gwaram", state: "Jigawa"},
  %{name: "Gwiwa", state: "Jigawa"},
  %{name: "Hadejia", state: "Jigawa"},
  %{name: "Jahun", state: "Jigawa"},
  %{name: "Kafin Hausa", state: "Jigawa"},
  %{name: "Kaugama Kazaure", state: "Jigawa"},
  %{name: "Kiri Kasamma", state: "Jigawa"},
  %{name: "Kiyawa", state: "Jigawa"},
  %{name: "Maigatari", state: "Jigawa"},
  %{name: "Malam Madori", state: "Jigawa"},
  %{name: "Miga", state: "Jigawa"},
  %{name: "Ringim", state: "Jigawa"},
  %{name: "Roni", state: "Jigawa"},
  %{name: "Sule-Tankarkar", state: "Jigawa"},
  %{name: "Taura", state: "Jigawa"},
  %{name: "Yankwashi", state: "Jigawa"},
  %{name: "Birni-Gwari", state: "Kaduna"},
  %{name: "Chikun", state: "Kaduna"},
  %{name: "Giwa", state: "Kaduna"},
  %{name: "Igabi", state: "Kaduna"},
  %{name: "Ikara", state: "Kaduna"},
  %{name: "jaba", state: "Kaduna"},
  %{name: "Jema'a", state: "Kaduna"},
  %{name: "Kachia", state: "Kaduna"},
  %{name: "Kaduna North", state: "Kaduna"},
  %{name: "Kaduna South", state: "Kaduna"},
  %{name: "Kagarko", state: "Kaduna"},
  %{name: "Kajuru", state: "Kaduna"},
  %{name: "Kaura", state: "Kaduna"},
  %{name: "Kauru", state: "Kaduna"},
  %{name: "Kubau", state: "Kaduna"},
  %{name: "Kudan", state: "Kaduna"},
  %{name: "Lere", state: "Kaduna"},
  %{name: "Makarfi", state: "Kaduna"},
  %{name: "Sabon-Gari", state: "Kaduna"},
  %{name: "Sanga", state: "Kaduna"},
  %{name: "Soba", state: "Kaduna"},
  %{name: "Zango-Kataf", state: "Kaduna"},
  %{name: "Zaria", state: "Kaduna"},
  %{name: "Ajingi", state: "Kano"},
  %{name: "Albasu", state: "Kano"},
  %{name: "Bagwai", state: "Kano"},
  %{name: "Bebeji", state: "Kano"},
  %{name: "Bichi", state: "Kano"},
  %{name: "Bunkure", state: "Kano"},
  %{name: "Dala", state: "Kano"},
  %{name: "Dambatta", state: "Kano"},
  %{name: "Dawakin Kudu", state: "Kano"},
  %{name: "Dawakin Tofa", state: "Kano"},
  %{name: "Doguwa", state: "Kano"},
  %{name: "Fagge", state: "Kano"},
  %{name: "Gabasawa", state: "Kano"},
  %{name: "Garko", state: "Kano"},
  %{name: "Garum", state: "Kano"},
  %{name: "Mallam", state: "Kano"},
  %{name: "Gaya", state: "Kano"},
  %{name: "Gezawa", state: "Kano"},
  %{name: "Gwale", state: "Kano"},
  %{name: "Gwarzo", state: "Kano"},
  %{name: "Kabo", state: "Kano"},
  %{name: "Kano Municipal", state: "Kano"},
  %{name: "Karaye", state: "Kano"},
  %{name: "Kibiya", state: "Kano"},
  %{name: "Kiru", state: "Kano"},
  %{name: "kumbotso", state: "Kano"},
  %{name: "Kunchi", state: "Kano"},
  %{name: "Kura", state: "Kano"},
  %{name: "Madobi", state: "Kano"},
  %{name: "Makoda", state: "Kano"},
  %{name: "Minjibir", state: "Kano"},
  %{name: "Nasarawa", state: "Kano"},
  %{name: "Rano", state: "Kano"},
  %{name: "Rimin Gado", state: "Kano"},
  %{name: "Rogo", state: "Kano"},
  %{name: "Shanono", state: "Kano"},
  %{name: "Sumaila", state: "Kano"},
  %{name: "Takali", state: "Kano"},
  %{name: "Tarauni", state: "Kano"},
  %{name: "Tofa", state: "Kano"},
  %{name: "Tsanyawa", state: "Kano"},
  %{name: "Tudun Wada", state: "Kano"},
  %{name: "Ungogo", state: "Kano"},
  %{name: "Warawa", state: "Kano"},
  %{name: "Wudil", state: "Kano"},
  %{name: "Bakori", state: "Katsina"},
  %{name: "Batagarawa", state: "Katsina"},
  %{name: "Batsari", state: "Katsina"},
  %{name: "Baure", state: "Katsina"},
  %{name: "Bindawa", state: "Katsina"},
  %{name: "Charanchi", state: "Katsina"},
  %{name: "Dandume", state: "Katsina"},
  %{name: "Danja", state: "Katsina"},
  %{name: "Dan Musa", state: "Katsina"},
  %{name: "Daura", state: "Katsina"},
  %{name: "Dutsi", state: "Katsina"},
  %{name: "Dutsin-Ma", state: "Katsina"},
  %{name: "Faskari", state: "Katsina"},
  %{name: "Funtua", state: "Katsina"},
  %{name: "Ingawa", state: "Katsina"},
  %{name: "Jibia", state: "Katsina"},
  %{name: "Kafur", state: "Katsina"},
  %{name: "Kaita", state: "Katsina"},
  %{name: "Kankara", state: "Katsina"},
  %{name: "Kankia", state: "Katsina"},
  %{name: "Katsina", state: "Katsina"},
  %{name: "Kurfi", state: "Katsina"},
  %{name: "Kusada", state: "Katsina"},
  %{name: "Mai'Adua", state: "Katsina"},
  %{name: "Malumfashi", state: "Katsina"},
  %{name: "Mani", state: "Katsina"},
  %{name: "Mashi", state: "Katsina"},
  %{name: "Matazuu", state: "Katsina"},
  %{name: "Musawa", state: "Katsina"},
  %{name: "Rimi", state: "Katsina"},
  %{name: "Sabuwa", state: "Katsina"},
  %{name: "Safana", state: "Katsina"},
  %{name: "Sandamu", state: "Katsina"},
  %{name: "Zango", state: "Katsina"},
  %{name: "Aleiro", state: "Kebbi"},
  %{name: "Arewa-Dandi", state: "Kebbi"},
  %{name: "Argungu", state: "Kebbi"},
  %{name: "Augie", state: "Kebbi"},
  %{name: "Bagudo", state: "Kebbi"},
  %{name: "Birnin Kebbi", state: "Kebbi"},
  %{name: "Bunza", state: "Kebbi"},
  %{name: "Dandi", state: "Kebbi"},
  %{name: "Fakai", state: "Kebbi"},
  %{name: "Gwandu", state: "Kebbi"},
  %{name: "Jega", state: "Kebbi"},
  %{name: "Kalgo", state: "Kebbi"},
  %{name: "Koko/Besse", state: "Kebbi"},
  %{name: "Maiyama", state: "Kebbi"},
  %{name: "Ngaski", state: "Kebbi"},
  %{name: "Sakaba", state: "Kebbi"},
  %{name: "Shanga", state: "Kebbi"},
  %{name: "Suru", state: "Kebbi"},
  %{name: "Wasagu/Danko", state: "Kebbi"},
  %{name: "Yauri", state: "Kebbi"},
  %{name: "Zuru", state: "Kebbi"},
  %{name: "Adavi", state: "Kogi"},
  %{name: "Ajaokuta", state: "Kogi"},
  %{name: "Ankpa", state: "Kogi"},
  %{name: "Bassa", state: "Kogi"},
  %{name: "Dekina", state: "Kogi"},
  %{name: "Ibaji", state: "Kogi"},
  %{name: "Idah", state: "Kogi"},
  %{name: "Igalamela-Odolu", state: "Kogi"},
  %{name: "Ijumu", state: "Kogi"},
  %{name: "Kabba/Bunu", state: "Kogi"},
  %{name: "Kogi", state: "Kogi"},
  %{name: "Lokoja", state: "Kogi"},
  %{name: "Mopa-Muro", state: "Kogi"},
  %{name: "Ofu", state: "Kogi"},
  %{name: "Ogori/Mangongo", state: "Kogi"},
  %{name: "Okehi", state: "Kogi"},
  %{name: "Okene", state: "Kogi"},
  %{name: "Olamabolo", state: "Kogi"},
  %{name: "Omala", state: "Kogi"},
  %{name: "Yagba East", state: "Kogi"},
  %{name: "Yagba West", state: "Kogi"},
  %{name: "Asa", state: "Kwara"},
  %{name: "Baruten", state: "Kwara"},
  %{name: "Edu", state: "Kwara"},
  %{name: "Ekiti", state: "Kwara"},
  %{name: "Ifelodun", state: "Kwara"},
  %{name: "Ilorin East", state: "Kwara"},
  %{name: "Ilorin West", state: "Kwara"},
  %{name: "Irepodun", state: "Kwara"},
  %{name: "Isin", state: "Kwara"},
  %{name: "Kaiama", state: "Kwara"},
  %{name: "Moro", state: "Kwara"},
  %{name: "Offa", state: "Kwara"},
  %{name: "Oke-Ero", state: "Kwara"},
  %{name: "Oyun", state: "Kwara"},
  %{name: "Pategi", state: "Kwara"},
  %{name: "Agege", state: "Lagos"},
  %{name: "Ajeromi-Ifelodun", state: "Lagos"},
  %{name: "Alimosho", state: "Lagos"},
  %{name: "Amuwo-Odofin", state: "Lagos"},
  %{name: "Apapa", state: "Lagos"},
  %{name: "Badagry", state: "Lagos"},
  %{name: "Epe", state: "Lagos"},
  %{name: "Eti-Osa", state: "Lagos"},
  %{name: "Ibeju/Lekki", state: "Lagos"},
  %{name: "Ifako-Ijaye", state: "Lagos"},
  %{name: "Ikeja", state: "Lagos"},
  %{name: "Ikorodu", state: "Lagos"},
  %{name: "Kosofe", state: "Lagos"},
  %{name: "Lagos Island", state: "Lagos"},
  %{name: "Lagos Mainland", state: "Lagos"},
  %{name: "Mushin", state: "Lagos"},
  %{name: "Ojo", state: "Lagos"},
  %{name: "Oshodi-Isolo", state: "Lagos"},
  %{name: "Shomolu", state: "Lagos"},
  %{name: "Surulere", state: "Lagos"},
  %{name: "Akwanga", state: "Nasarawa"},
  %{name: "Awe", state: "Nasarawa"},
  %{name: "Doma", state: "Nasarawa"},
  %{name: "Karu", state: "Nasarawa"},
  %{name: "Keana", state: "Nasarawa"},
  %{name: "Keffi", state: "Nasarawa"},
  %{name: "Kokona", state: "Nasarawa"},
  %{name: "Lafia", state: "Nasarawa"},
  %{name: "Nasarawa", state: "Nasarawa"},
  %{name: "Nasarawa-Eggon", state: "Nasarawa"},
  %{name: "Obi", state: "Nasarawa"},
  %{name: "Toto", state: "Nasarawa"},
  %{name: "Wamba", state: "Nasarawa"},
  %{name: "Agaie", state: "Niger"},
  %{name: "Agwara", state: "Niger"},
  %{name: "Bida", state: "Niger"},
  %{name: "Borgu", state: "Niger"},
  %{name: "Bosso", state: "Niger"},
  %{name: "Chanchaga", state: "Niger"},
  %{name: "Edati", state: "Niger"},
  %{name: "Gbako", state: "Niger"},
  %{name: "Gurara", state: "Niger"},
  %{name: "Katcha", state: "Niger"},
  %{name: "Kontagora", state: "Niger"},
  %{name: "Lapai", state: "Niger"},
  %{name: "Lavun", state: "Niger"},
  %{name: "Magama", state: "Niger"},
  %{name: "Mariga", state: "Niger"},
  %{name: "Mashegu", state: "Niger"},
  %{name: "Mokwa", state: "Niger"},
  %{name: "Muya", state: "Niger"},
  %{name: "Pailoro", state: "Niger"},
  %{name: "Rafi", state: "Niger"},
  %{name: "Rijau", state: "Niger"},
  %{name: "Shiroro", state: "Niger"},
  %{name: "Suleja", state: "Niger"},
  %{name: "Tafa", state: "Niger"},
  %{name: "Wushishi", state: "Niger"},
  %{name: "Abeokuta North", state: "Ogun"},
  %{name: "Abeokuta South", state: "Ogun"},
  %{name: "Ado-Odo/Ota", state: "Ogun"},
  %{name: "Egbado North", state: "Ogun"},
  %{name: "Egbado South", state: "Ogun"},
  %{name: "Ewekoro", state: "Ogun"},
  %{name: "Ifo", state: "Ogun"},
  %{name: "Ijebu East", state: "Ogun"},
  %{name: "Ijebu North", state: "Ogun"},
  %{name: "Ijebu North East", state: "Ogun"},
  %{name: "Ijebu Ode", state: "Ogun"},
  %{name: "Ikenne", state: "Ogun"},
  %{name: "Imeko-Afon", state: "Ogun"},
  %{name: "Ipokia", state: "Ogun"},
  %{name: "Obafemi-Owode", state: "Ogun"},
  %{name: "Ogun Waterside", state: "Ogun"},
  %{name: "Odeda", state: "Ogun"},
  %{name: "Odogbolu", state: "Ogun"},
  %{name: "Remo North", state: "Ogun"},
  %{name: "Shagamu", state: "Ogun"},
  %{name: "Akoko North East", state: "Ondo"},
  %{name: "Akoko North West", state: "Ondo"},
  %{name: "Akoko South Akure East", state: "Ondo"},
  %{name: "Akoko South West", state: "Ondo"},
  %{name: "Akure North", state: "Ondo"},
  %{name: "Akure South", state: "Ondo"},
  %{name: "Ese-Odo", state: "Ondo"},
  %{name: "Idanre", state: "Ondo"},
  %{name: "Ifedore", state: "Ondo"},
  %{name: "Ilaje", state: "Ondo"},
  %{name: "Ile-Oluji", state: "Ondo"},
  %{name: "Okeigbo", state: "Ondo"},
  %{name: "Irele", state: "Ondo"},
  %{name: "Odigbo", state: "Ondo"},
  %{name: "Okitipupa", state: "Ondo"},
  %{name: "Ondo East", state: "Ondo"},
  %{name: "Ondo West", state: "Ondo"},
  %{name: "Ose", state: "Ondo"},
  %{name: "Owo", state: "Ondo"},
  %{name: "Aiyedade", state: "Osun"},
  %{name: "Aiyedire", state: "Osun"},
  %{name: "Atakumosa East", state: "Osun"},
  %{name: "Atakumosa West", state: "Osun"},
  %{name: "Boluwaduro", state: "Osun"},
  %{name: "Boripe", state: "Osun"},
  %{name: "Ede North", state: "Osun"},
  %{name: "Ede South", state: "Osun"},
  %{name: "Egbedore", state: "Osun"},
  %{name: "Ejigbo", state: "Osun"},
  %{name: "Ife Central", state: "Osun"},
  %{name: "Ife East", state: "Osun"},
  %{name: "Ife North", state: "Osun"},
  %{name: "Ife South", state: "Osun"},
  %{name: "Ifedayo", state: "Osun"},
  %{name: "Ifelodun", state: "Osun"},
  %{name: "Ila", state: "Osun"},
  %{name: "Ilesha East", state: "Osun"},
  %{name: "Ilesha West", state: "Osun"},
  %{name: "Irepodun", state: "Osun"},
  %{name: "Irewole", state: "Osun"},
  %{name: "Isokan", state: "Osun"},
  %{name: "Iwo", state: "Osun"},
  %{name: "Obokun", state: "Osun"},
  %{name: "Odo-Otin", state: "Osun"},
  %{name: "Ola-Oluwa", state: "Osun"},
  %{name: "Olorunda", state: "Osun"},
  %{name: "Oriade", state: "Osun"},
  %{name: "Orolu", state: "Osun"},
  %{name: "Osogbo", state: "Osun"},
  %{name: "Afijio", state: "Oyo"},
  %{name: "Akinyele", state: "Oyo"},
  %{name: "Atiba", state: "Oyo"},
  %{name: "Atigbo", state: "Oyo"},
  %{name: "Egbeda", state: "Oyo"},
  %{name: "IbadanCentral", state: "Oyo"},
  %{name: "Ibadan North", state: "Oyo"},
  %{name: "Ibadan North West", state: "Oyo"},
  %{name: "Ibadan South East", state: "Oyo"},
  %{name: "Ibadan South West", state: "Oyo"},
  %{name: "Ibarapa Central", state: "Oyo"},
  %{name: "Ibarapa East", state: "Oyo"},
  %{name: "Ibarapa North", state: "Oyo"},
  %{name: "Ido", state: "Oyo"},
  %{name: "Irepo", state: "Oyo"},
  %{name: "Iseyin", state: "Oyo"},
  %{name: "Itesiwaju", state: "Oyo"},
  %{name: "Iwajowa", state: "Oyo"},
  %{name: "Kajola", state: "Oyo"},
  %{name: "Lagelu Ogbomosho North", state: "Oyo"},
  %{name: "Ogbmosho South", state: "Oyo"},
  %{name: "Ogo Oluwa", state: "Oyo"},
  %{name: "Olorunsogo", state: "Oyo"},
  %{name: "Oluyole", state: "Oyo"},
  %{name: "Ona-Ara", state: "Oyo"},
  %{name: "Orelope", state: "Oyo"},
  %{name: "Ori Ire", state: "Oyo"},
  %{name: "Oyo East", state: "Oyo"},
  %{name: "Oyo West", state: "Oyo"},
  %{name: "Saki East", state: "Oyo"},
  %{name: "Saki West", state: "Oyo"},
  %{name: "Surulere", state: "Oyo"},
  %{name: "Barikin Ladi", state: "Plateau"},
  %{name: "Bassa", state: "Plateau"},
  %{name: "Bokkos", state: "Plateau"},
  %{name: "Jos East", state: "Plateau"},
  %{name: "Jos North", state: "Plateau"},
  %{name: "Jos South", state: "Plateau"},
  %{name: "Kanam", state: "Plateau"},
  %{name: "Kanke", state: "Plateau"},
  %{name: "Langtang North", state: "Plateau"},
  %{name: "Langtang South", state: "Plateau"},
  %{name: "Mangu", state: "Plateau"},
  %{name: "Mikang", state: "Plateau"},
  %{name: "Pankshin", state: "Plateau"},
  %{name: "Qua'an Pan", state: "Plateau"},
  %{name: "Riyom", state: "Plateau"},
  %{name: "Shendam", state: "Plateau"},
  %{name: "Wase", state: "Plateau"},
  %{name: "Abua/Odual", state: "Rivers"},
  %{name: "Ahoada East", state: "Rivers"},
  %{name: "Ahoada West", state: "Rivers"},
  %{name: "Akuku Toru", state: "Rivers"},
  %{name: "Andoni", state: "Rivers"},
  %{name: "Asari-Toru", state: "Rivers"},
  %{name: "Bonny", state: "Rivers"},
  %{name: "Degema", state: "Rivers"},
  %{name: "Emohua", state: "Rivers"},
  %{name: "Eleme", state: "Rivers"},
  %{name: "Etche", state: "Rivers"},
  %{name: "Gokana", state: "Rivers"},
  %{name: "Ikwerre", state: "Rivers"},
  %{name: "Khana", state: "Rivers"},
  %{name: "Obia/Akpor", state: "Rivers"},
  %{name: "Ogba/Egbema/Ndoni", state: "Rivers"},
  %{name: "Ogu/Bolo", state: "Rivers"},
  %{name: "Okrika", state: "Rivers"},
  %{name: "Omumma", state: "Rivers"},
  %{name: "Opobo/Nkoro", state: "Rivers"},
  %{name: "Oyigbo", state: "Rivers"},
  %{name: "Port-Harcourt", state: "Rivers"},
  %{name: "Tai", state: "Rivers"},
  %{name: "Binji", state: "Sokoto"},
  %{name: "Bodinga", state: "Sokoto"},
  %{name: "Dange-shnsi", state: "Sokoto"},
  %{name: "Gada", state: "Sokoto"},
  %{name: "Goronyo", state: "Sokoto"},
  %{name: "Gudu", state: "Sokoto"},
  %{name: "Gawabawa", state: "Sokoto"},
  %{name: "Illela", state: "Sokoto"},
  %{name: "Isa", state: "Sokoto"},
  %{name: "Kware", state: "Sokoto"},
  %{name: "kebbe", state: "Sokoto"},
  %{name: "Rabah", state: "Sokoto"},
  %{name: "Sabon birni", state: "Sokoto"},
  %{name: "Shagari", state: "Sokoto"},
  %{name: "Silame", state: "Sokoto"},
  %{name: "Sokoto North", state: "Sokoto"},
  %{name: "Sokoto South", state: "Sokoto"},
  %{name: "Tambuwal", state: "Sokoto"},
  %{name: "Tqngaza", state: "Sokoto"},
  %{name: "Tureta", state: "Sokoto"},
  %{name: "Wamako", state: "Sokoto"},
  %{name: "Wurno", state: "Sokoto"},
  %{name: "Yabo", state: "Sokoto"},
  %{name: "Ardo-kola", state: "Taraba"},
  %{name: "Bali", state: "Taraba"},
  %{name: "Donga", state: "Taraba"},
  %{name: "Gashaka", state: "Taraba"},
  %{name: "Cassol", state: "Taraba"},
  %{name: "Ibi", state: "Taraba"},
  %{name: "Jalingo", state: "Taraba"},
  %{name: "Karin-Lamido", state: "Taraba"},
  %{name: "Kurmi", state: "Taraba"},
  %{name: "Lau", state: "Taraba"},
  %{name: "Sardauna", state: "Taraba"},
  %{name: "Takum", state: "Taraba"},
  %{name: "Ussa", state: "Taraba"},
  %{name: "Wukari", state: "Taraba"},
  %{name: "Yorro", state: "Taraba"},
  %{name: "Zing", state: "Taraba"},
  %{name: "Bade", state: "Yobe"},
  %{name: "Bursari", state: "Yobe"},
  %{name: "Damaturu", state: "Yobe"},
  %{name: "Fika", state: "Yobe"},
  %{name: "Fune", state: "Yobe"},
  %{name: "Geidam", state: "Yobe"},
  %{name: "Gujba", state: "Yobe"},
  %{name: "Gulani", state: "Yobe"},
  %{name: "Jakusko", state: "Yobe"},
  %{name: "Karasuwa", state: "Yobe"},
  %{name: "Karawa", state: "Yobe"},
  %{name: "Machina", state: "Yobe"},
  %{name: "Nangere", state: "Yobe"},
  %{name: "Nguru Potiskum", state: "Yobe"},
  %{name: "Tarmua", state: "Yobe"},
  %{name: "Yunusari", state: "Yobe"},
  %{name: "Yusufari", state: "Yobe"},
  %{name: "Anka", state: "Zamfara"},
  %{name: "Bakura", state: "Zamfara"},
  %{name: "Birnin Magaji", state: "Zamfara"},
  %{name: "Bukkuyum", state: "Zamfara"},
  %{name: "Bungudu", state: "Zamfara"},
  %{name: "Gummi", state: "Zamfara"},
  %{name: "Gusau", state: "Zamfara"},
  %{name: "Kaura", state: "Zamfara"},
  %{name: "Namoda", state: "Zamfara"},
  %{name: "Maradun", state: "Zamfara"},
  %{name: "Maru", state: "Zamfara"},
  %{name: "Shinkafi", state: "Zamfara"},
  %{name: "Talata Mafara", state: "Zamfara"},
  %{name: "Tsafe", state: "Zamfara"},
  %{name: "Zurmi", state: "Zamfara"}
]
|> Enum.each( fn lga ->
    Repo.get_by(State, name: lga[:state])
    |> case do
        state ->
          LocalGovernmentArea |> Repo.get_by([name: lga[:name], state_id: state.id])
          |> case do
              nil ->
                LocalGovernmentArea.changeset(%LocalGovernmentArea{}, %{name: lga[:name], state_id: state.id})
                |> Repo.insert!
              _ -> IO.inspect "Existing"
            end
          nil -> IO.inspect "Not found"
      end
end)

state = Repo.get_by(State, name: "Delta")
cities = [
  %{name: "Abraka", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Agbarho", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Agbor", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Aladja", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Asaba", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Eku", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Effurun", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Isele-Uku", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Obiaruku", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Oghara", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ogwashi-Uku", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Oleh", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Otor-Udu", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ovwian", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ozoro", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Sapele", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ughelli", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Umunede", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Udu", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Warri", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
]
Enum.each(cities, fn city -> City.changeset(%City{}, city) |> Repo.insert! end )
state = Repo.get_by(State, name: "Rivers")
[
  %{name: "Abalama", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Abonnema", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ahoada", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Ataba", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Bane", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Bonny", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Bori", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Buguma", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Elele", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Emohua", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Igrita", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Igwuruta", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Nkoroo", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Odiabidi", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Okobie", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Okrika", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Omoku", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Onne", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Opobo", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Woji - Port Harcourt", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Abuloma - Port Harcourt", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
  %{name: "Rumuokoro", state_id: state.id, shipping_zone_id: state.shipping_zone_id},
]
|> Enum.each(fn city -> City.changeset(%City{}, city) |> Repo.insert! end )



[
  %{name: "Pending"},
  %{name: "Canceled"},
  %{name: "Refunded"},
  %{name: "Authorized"},
  %{name: "Paid"}
]
|> Enum.each(fn invoice_status ->
  case Repo.get_by(InvoiceStatus, [name: invoice_status[:name]]) do
    nil ->
      %InvoiceStatus{}
      |> InvoiceStatus.changeset(invoice_status)
      |> Repo.insert!()
    _ -> IO.inspect "Found"
  end
end
)

[ %{name: "Purchase"},  %{name: "RMA"}]
|> Enum.each(fn invoice_type ->
    case Repo.get_by(InvoiceType, name: invoice_type[:name]) do
      nil ->
        InvoiceType.changeset(%InvoiceType{}, invoice_type)
        |> Repo.insert!
      _ -> IO.inspect "Found"
    end
  end
)
[%{name: "pending"}, %{name: "authorized"}, %{name: "paid"}, %{name: "payment_declined"}, %{name: "canceled"}, %{name: "refunded"}]
|> Enum.each(fn invoice_status ->
    Repo.get_by(InvoiceStatus, [name: invoice_status[:name]])
    |> case do
        nil -> InvoiceStatus.changeset(%InvoiceStatus{}, invoice_status) |> Repo.insert!
        _ -> IO.inspect "Existing"
      end
end)
[ %{name: "Women's Clothing"},
  %{name: "Men's Clothing"},
  %{name: "Phones and Accessories"},
  %{name: "Computer & Office"},
  %{name: "Consumer Electronics"},
  %{name: "Jewelry & Watches"},
  %{name: "Home & Garden"},
  %{name: "Bags & Shoes"},
  %{name: "Toys, Kids & Baby"},
  %{name: "Sports & Outdoors"},
  %{name: "Health & Beauty"},
  %{name: "Automobiles & Motorcycle"},
  %{name: "Tools and Hardware"}]
|> save_product_category.()


women_clothing_category = get_product_category.("Women's Clothing")
[
  %{name: "Women's Dresses", parent_id: women_clothing_category.id},
  %{name: "Women's Tops", parent_id: women_clothing_category.id},
  %{name: "Women's Skirts", parent_id: women_clothing_category.id},
  %{name: "Women's Trousers", parent_id: women_clothing_category.id},
  %{name: "Lingerie and Sleepwear", parent_id: women_clothing_category.id},
  %{name: "Jumpsuits and Playsuits", parent_id: women_clothing_category.id},
  %{name: "Islamic Wear", parent_id: women_clothing_category.id},
  %{name: "Traditional Clothing", parent_id: women_clothing_category.id}
]
|> save_product_category.()

men_clothing_category = get_product_category.("Men's Clothing")
[
%{name: "Men's Shirts", parent_id: men_clothing_category.id},
%{name: "Men's Jeans", parent_id: men_clothing_category.id},
%{name: "Jerseys", parent_id: men_clothing_category.id},
%{name: "Men's Trousers and Shorts", parent_id: men_clothing_category.id},
%{name: "Suits, Blazers & Jackets", parent_id: men_clothing_category.id},
%{name: "Men's Nightwear", parent_id: men_clothing_category.id},
%{name: "Polo Shirts", parent_id: men_clothing_category.id},
%{name: "Men's T-Shirts", parent_id: men_clothing_category.id}
]
|> save_product_category.()

computer_category = get_product_category.("Computer & Office")
[
%{name: "Computing Accessories", parent_id: computer_category.id},
%{name: "Desktop and Monitors", parent_id: computer_category.id},
%{name: "Laptops", parent_id: computer_category.id},
%{name: "Networking", parent_id: computer_category.id},
%{name: "Printers, Scanners and Accessories", parent_id: computer_category.id},
%{name: "Projectors & Accessories", parent_id: computer_category.id},
%{name: "Computer Software", parent_id: computer_category.id},
]
|> save_product_category.()

product_category = Repo.get_by(ProductCategory, name: "Laptops")
[
  %{name: "HP", product_category_id: product_category.id},
  %{name: "Dell", product_category_id: product_category.id},
  %{name: "Apple", product_category_id: product_category.id},
  %{name: "Lenovo", product_category_id: product_category.id},
  %{name: "Acer", product_category_id: product_category.id},
  %{name: "Toshiba", product_category_id: product_category.id},
  %{name: "Asus", product_category_id: product_category.id},
  %{name: "Razor", product_category_id: product_category.id}
]
|> Enum.each(fn brand -> 
  case Repo.get_by(Brand, name: brand[:name]) do
    nil -> Brand.changeset(%Brand{}, brand) |> Repo.insert!
    _ -> IO.inspect "Insertion failed due to duplication"
  end 
end)

[
  %{name: "Reseller", code: "RSL"}, 
  %{name: "Buyer", code: "BYR"},
  %{name: "Manufacturer", code: "MFT"}, 
  %{name: "Distributor", code: "DST"}
]
|> Enum.each(fn user_type -> 
  case Repo.get_by(UserType, name: user_type[:name]) do
    nil -> UserType.changeset(%UserType{}, user_type) |> Repo.insert!
    _ -> IO.inspect "Insertion failed due to duplication"
  end 
end)
[%{name: "Individual"}, %{name: "Order"}]
|> Enum.each(&(ShippingCategory.changeset(%ShippingCategory{}, &1) |> Repo.insert!))

state = Repo.get_by(State, name: "Delta")

[
  %{ 
    first_name: "Smith", last_name: "Samuel", email: "smithaitufe@live.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100001",
    address: %{ address: "8, Black Moore Street, Off Culvet, Woji", landmark: "Welcome U", phone_number: "08050999022", city_id: Repo.get_by(City, [state_id: Repo.get_by(State, name: "Rivers").id, name: "Woji - Port Harcourt"]).id}
  },
  %{ first_name: "Goodnews", last_name: "Emeka", email: "goodnewsemek@outlook.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("RSL").id, code: "OM/RSL/100001"},
  %{ 
    first_name: "Charles", last_name: "Omordia", email: "c.omordia@schoolville.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100002",
    address: %{ address: "102, Okpanam Road, Off Legislator's Quarters, Okpanam", landmark: "Shoprite", phone_number: "08050999022", city_id: Repo.get_by(City, [state_id: state.id, name: "Asaba"]).id}
  },
  %{
    first_name: "Patrick", last_name: "Acha", email: "p.acha@schoolville.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100003",
    address: %{ address: "102, Okpanam Road, Off Legislator's Quarters, Okpanam", landmark: "Shoprite", phone_number: "08050999022", city_id: Repo.get_by(City, [state_id: state.id, name: "Asaba"]).id}
  },
  %{ 
    first_name: "Stanley", last_name: "Oyibo", email: "s.oyibo@schoolville.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100004",
    address: %{ address: "102, Okpanam Road, Off Legislator's Quarters, Okpanam", landmark: "Legislator's Quarters", phone_number: "08050999022", city_id: Repo.get_by(City, [state_id: state.id, name: "Asaba"]).id}
  },
  %{ first_name: "Omejero", last_name: "Akpotaire", email: "omejakpos@gmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100005"},
  %{ first_name: "Judith", last_name: "Chuku", email: "judith4lifewithchucks@gmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100006"},
  %{ first_name: "Jennifer", last_name: "George", email: "jennygeorge@gmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100007"},
  %{ first_name: "Janet", last_name: "Lee", email: "janet.lee@gmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100008"},
  %{ first_name: "Precious", last_name: "Nwaigwe", email: "missprec@gmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100009"},
  %{ first_name: "Stephen", last_name: "Oboh", email: "stephen.oboh@yahoo.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100010"},
  %{ first_name: "Henry", last_name: "Scott", email: "henryisscott@hotmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("BYR").id, code: "OM/BYR/100011"},
  %{ first_name: "Oluchi", last_name: "Ifeanyi", email: "oluchiifea@hotmail.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("RSL").id, code: "OM/RSL/100002"},
  %{ first_name: "Brown", last_name: "Chike", email: "brownchike@yahoo.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("RSL").id, code: "OM/RSL/100003"},
  %{ first_name: "Chukwuemeka", last_name: "Chidozie", email: "ccz@yahoo.com", password: "password", password_confirmation: "password", user_type_id: get_user_type.("RSL").id, code: "OM/RSL/100004"},
]
|> Enum.each(fn user_params -> 
    {:ok, user} = User.changeset(%User{}, user_params) |> Repo.insert
    case Map.get(user_params, :address) do
      nil -> IO.inspect "No address for user #{user.last_name}"
      address -> address = Map.merge(address, %{user_id: user.id, last_name: user.last_name, first_name: user.first_name})
      Address.changeset(%Address{}, address) |> Repo.insert
    end
  end
)



[
  %{user_id: Repo.get_by(User, email: "goodnewsemek@outlook.com").id, name: "Goodies Stores", phone_number: "08032234567", email: "goodiessales@outlook.com", slogan: "Your babies look is your voice"},
  %{user_id: Repo.get_by(User, email: "oluchiifea@hotmail.com").id, name: "Ifeanyi & Sons", phone_number: "08089994768", email: "ifeanyssonssupport@hotmail.com", slogan: "We provide spare parts of all automobiles"},
  %{user_id: Repo.get_by(User, email: "brownchike@yahoo.com").id, name: "M & M Merchants", phone_number: "08045678900", email: "mmmerchants@yahoo.com", slogan: "Dealers of building materials"},
  %{user_id: Repo.get_by(User, email: "ccz@yahoo.com").id, name: "C C Stores", phone_number: "08045678900", email: "ccstores@yahoo.com", slogan: "Clothing is a need of humanity"},
  

]
|> Enum.each(fn shop_params -> Shop.changeset(%Shop{}, shop_params) |> Repo.insert end)

shop = Repo.get_by(Shop, email: "goodiessales@outlook.com")

[%{name: "Color", shop_id: shop.id}, %{name: "Size", shop_id: shop.id}, %{name: "Condition", shop_id: shop.id}] |> Enum.each(&(OptionGroup.changeset(%OptionGroup{}, &1) |> Repo.insert))

options = [
  colors: [%{name: "Red"}, %{name: "Blue"}, %{name: "Pink"}, %{name: "Green"}],
  sizes: [%{name: "SM"}, %{name: "L"}, %{name: "M"}, %{name: "XL"}]
]

color = Repo.get_by(OptionGroup, [name: "Color"])
for c <- options[:colors], do: Option.changeset(%Option{}, Map.put(c, :option_group_id, color.id)) |> Repo.insert

size = Repo.get_by(OptionGroup, [name: "Size"])
for c <- options[:sizes], do: Option.changeset(%Option{}, Map.put(c, :option_group_id, size.id)) |> Repo.insert


brand = Repo.get_by(Brand, name: "HP")
shipping_category = Repo.all(ShippingCategory |> order_by([desc: :id])) |> List.first

[
  %{
  shop_id: Repo.get_by(Shop, email: "ifeanyssonssupport@hotmail.com").id,
  brand_id: Repo.get_by(Brand, name: "Dell").id, 
  product_category_id: brand.product_category_id, 
  shipping_category_id: shipping_category.id,
  name: ~s(Dell Inspiron 15 i7559-5012GRY Signature Edition Laptop),
  short_description: "<ul><li>15.6-inch 4K UHD Touchscreen</li><li>Intel i7 6th Gen</li><li>8GB Memory/1TB SSHD</li><li>Nvidia Geforce GTX 960M Graphics</li></ul>",
  permalink: "dell-inspiron-15-i7559-5012gry-signature-edition-laptop",
  keywords: "hp, quad core, intel, pentium, 2.16ghz"
  },
  %{
  shop_id: Repo.get_by(Shop, email: "goodiessales@outlook.com").id,
  brand_id: brand.id, 
  product_category_id: brand.product_category_id, 
  shipping_category_id: shipping_category.id,
  name: ~s(2017 NEWEST HP 15-F222WM 15.6" Touch Screen Laptop - Intel Quad Core Pentium N3540 Processor, 4GB Memory, 500GB Hard Drive, DVD±RW/CD-RW, HD Webcam Windows 10),
  short_description: "<ul><li>Intel Pentium Quad Core N3540 processor 2.16GHz (up to 2.66GHz via Turbo boost)</li><li>4GB DDR3L SDRAM/500GB Serial ATA hard drive (5400 rpm)</li><li>15.6-inch high-definition display/1366 x 768 resolution touchscreen</li><li>DVD±RW/CD-RW drive/Built-in webcam and integrated digital microphone</li><li>Windows 10 64-bit /Built-in wireless LAN (802.11b/g/n</li></ul>",
  permalink: "HP-15-f222WM",
  keywords: "dell, inspiron, 15,ram, quad core, intel"
}
]
|> Enum.each(fn product_params -> Product.changeset(%Product{}, product_params) |> Repo.insert! end)

product = Repo.get(Product, 2)
Variant.changeset(%Variant{}, %{product_id: product.id, name: product.name, sku: "32989hn89", price: 150000, cost: 145000, weight: 2}) |> Repo.insert!
product = Repo.get(Product, 1)
Variant.changeset(%Variant{}, %{product_id: product.id, name: product.name, sku: "kk45768390", price: 250000, cost: 195000, weight: 2}) |> Repo.insert!

state = Repo.get_by(State, name: "Delta")
user = Repo.get_by(User, email: "smithaitufe@live.com")

case Cart.changeset(%Cart{}, %{user_id: user.id}) |> Repo.insert do
  {:ok, cart} -> CartItem.changeset(%CartItem{}, %{cart_id: cart.id, variant_id: Repo.get(Variant, 1).id, item_type_id: Repo.get_by(ItemType, name: "shopping_cart").id }) |> Repo.insert!

end



[
  %{identifying_name: "Weight (kg)", display_name: "Weight (kg)", shop_id: shop.id},
  %{identifying_name: "Resolution", display_name: "Resolution", shop_id: shop.id},
  %{identifying_name: "Backlit Keyboard", display_name: "Backlit Keyboard", shop_id: shop.id},
  %{identifying_name: "RAM", display_name: "RAM", shop_id: shop.id},
  %{identifying_name: "HDD", display_name: "HDD", shop_id: shop.id},
  %{identifying_name: "Screen Size", display_name: "Screen Size", shop_id: shop.id},
  %{identifying_name: "Display", display_name: "Display", shop_id: shop.id},
  %{identifying_name: "Back Camera", display_name: "Back Camera", shop_id: shop.id},
  %{identifying_name: "Front Camera", display_name: "Front Camera", shop_id: shop.id},
  %{identifying_name: "Processor", display_name: "Processor", shop_id: shop.id},
  %{identifying_name: "Color", display_name: "Color", shop_id: shop.id},
  %{identifying_name: "Manufacturer", display_name: "Manufacturer", shop_id: shop.id},
  %{identifying_name: "Capacity", display_name: "Capacity", shop_id: shop.id},
  %{identifying_name: "Volume", display_name: "Volume", shop_id: shop.id},
  %{identifying_name: "Length", display_name: "Length", shop_id: shop.id},
  %{identifying_name: "Material", display_name: "Material", shop_id: shop.id},
  %{identifying_name: "Price", display_name: "Price", shop_id: shop.id},
  %{identifying_name: "Code", display_name: "Code", shop_id: shop.id},
]
|> Enum.each(&(Property.changeset(%Property{}, &1) |> Repo.insert!))

[
  %{name: "Laptop", shop_id: shop.id},
  %{name: "Yam", shop_id: shop.id},
  %{name: "Car", shop_id: shop.id}
]
|> Enum.each(&(Prototype.changeset(%Prototype{}, &1) |> Repo.insert!))

prototype = Repo.get!(Prototype, 1)
properties = Repo.all(Property)

for property <- properties, property.id < 6 do
  PrototypeProperty.changeset(%PrototypeProperty{}, %{prototype_id: prototype.id, property_id: property.id}) |> Repo.insert!
end
product = Product |> Repo.all |> List.first
[
  %{name: "Red Shoes", product_id: product.id},
  %{name: "Black Shoes", product_id: product.id},
  %{name: "Brown Shoes", product_id: product.id}
]
|> Enum.each(&(ImageGroup.changeset(%ImageGroup{}, &1) |> Repo.insert!))


[:ex_aws, :hackney, :arc] |> Enum.each(&(Application.ensure_all_started(&1)))

image_path = "/home/smith/Downloads/istock-000057793060-large.jpg"
Repo.insert!(%Image{name: "istock-000057793060-large.jpg"})
image = Repo.all(Image) |> List.first
# Image.store(image_path, image)

ProductImage.changeset(%ProductImage{}, %{product_id: product.id, image_id: image.id}) |> Repo.insert!