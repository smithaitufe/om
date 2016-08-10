rule = "============================================================================================================"
alias Store.{Repo, Country, AddressType, ItemType, TaxRate, OrderStatus, OrderState, ShippingZone, State, LocalGovernmentArea, InvoiceType, InvoiceStatus}
alias Timex.{Date}

country  = Repo.get_by(Country, [name: "Nigeria"])
if country == nil do
  Repo.insert!(%Country{name: "Nigeria", abbreviation: "NG"})
end
IO.puts rule

[
  %{name: "Nation Wide"},
  %{name: "Area Wide"}
]
|> Enum.each(fn shipping_zone ->
    Repo.get_by(ShippingZone, name: shipping_zone[:name])
    |> case do
      nil -> ShippingZone.changeset(shipping_zone)
      |> Repo.insert!()
      _ -> IO.inspect "Existing already"
    end
end)

country  = Repo.get_by(Country, [name: "Nigeria"])
case Repo.get_by(TaxRate,  [country_id: country.id, percentage: 5]) do
  nil ->  TaxRate.changeset(%TaxRate{}, %{country_id: country.id, percentage: 5})
  |> Repo.insert!(changeset)
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
    nil ->  OrderStatus.changeset(%OrderStatus{}, order_status)
    |> Repo.insert!(changeset)
    _ -> IO.inspect "Existing"
  end
end )

IO.puts rule
address_types = [%{name: "Billing Address"}, %{name: "Shipping Address"}]
for at <- address_types do
  changeset = AddressType.changeset(%AddressType{}, at)
  Repo.insert!(changeset)
end
IO.puts rule

item_types = [%{name: "shopping_cart"},%{name: "save_for_later"},%{name: "wish_list"}, %{name: "purchased"}]
for item_type <- item_types do
  found = Repo.get_by(ItemType, [name: item_type[:name]])
  if (found == nil) do
    changeset = ItemType.changeset(%ItemType{}, item_type)
    Repo.insert!(changeset)
  end
end

country = Country |> Repo.get_by(name: "Nigeria")
states =[
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

for s <- states do
  Repo.transaction fn ->
    result = State |> Repo.get_by([country_id: country.id, name: s.name])
    if result == nil do
      state_params = Map.put(s, :country_id, country.id)
      changeset = State.changeset(%State{}, state_params)
      if changeset.valid?, do: Repo.insert(changeset)
    end
  end
end
IO.puts rule

lga_list =[
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

for lga <- lga_list do
  state = Repo.get_by(State, name: lga[:state])
  result = LocalGovernmentArea |> Repo.get_by([name: lga[:name], state_id: state.id])
  if result == nil do
    lga_params = %{name: lga[:name], state_id: state.id}
    changeset = LocalGovernmentArea.changeset(%LocalGovernmentArea{}, lga_params)
    if changeset.valid?, do: Repo.insert!(changeset)
  end
end

[
  %{name: "Pending"},
  %{name: "Canceled"},
  %{name: "Refunded"},
  %{name: "Authorized"},
  %{name: "Paid"}
]
|> Enum.each(fn invoice_type ->
    %InvoiceStatus{}
    |> InvoiceStatus.changeset(invoice_type)
    |> Repo.insert!()
  end
)



[
  %{name: "Purchase"},
  %{name: "RMA"}
]
|> Enum.each(fn invoice_type ->
    %InvoiceType{}
    |> InvoiceType.changeset(invoice_type)
    |> Repo.insert!()
  end
)
