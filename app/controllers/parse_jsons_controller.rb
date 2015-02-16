# Google map api "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address}"
# Goviroment open data "http://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$filter=縣市+like+台北市"
class ParseJsonsController < ApplicationController
  def index
    @parse_jsons = ParseJson.all
  end

  def new
    @parse_json = ParseJson.new
  end

  def edit
    @parse_json = ParseJson.find(params[:id])
  end
  
  def destroy
    @parse_json = ParseJson.find(params[:id])
    @parse_json.destroy
    redirect_to parse_jsons_url, :notice => "Successfully destroyed parse json."
  end  

  def create
    # render :plain => params[:parse_json][:minor_type_id]
    @parse_json = ParseJson.new(parse_json_params)
    @parse_json.save
    @last_parse_json = ParseJson.last
    import_data_by(params)
    redirect_to root_path 
  end

    # 縣市
    # 字號
    # 執照類別
    # 狀態
    # 機構名稱
    # 負責獸醫
    # 發照日期
    # 機構地址
private    
  def import_data_by(parameters)
    # address = params[:transfor]
    # address = address[:address]
    address = parameters[:parse_json][:address]
    address = URI.escape(address)
    address = Net::HTTP.get(URI.parse(address))    
    parsed_data = JSON.parse(address)

    name = "" # "機構名稱"
    if parameters[:name]
      name = parameters[:name]
    end

    city = "" # "縣市"
    if parameters[:city]
      city = parameters[:city]
    end

    address = "" # "機構地址"
    if parameters[:address]
      address = parameters[:address]
    end

    info1 = # "字號"
    if parameters[:other_info_1]
      info1 = parameters[:other_info_1]
    end

    info2 = # "執照類別 "
    if parameters[:other_info_2]
      info2 = parameters[:other_info_2]
    end

    info3 = # "狀態"
    if parameters[:other_info_3]
      info3 = parameters[:other_info_3]
    end

    info4 = # "負責獸醫"
    if parameters[:other_info_4]
      info4 = parameters[:other_info_4]
    end

    info5 = # "負責獸醫"
    if parameters[:other_info_5]
      info5 = parameters[:other_info_5]
    end

    major_type = MajorType.find(parameters[:parse_json][:major_type_id])
    minor_type = MinorType.find(parameters[:parse_json][:minor_type_id])

    parsed_data.map do |line|
      store_parameters = Hash.new
      store_parameters[:name] = line[name]
      store_parameters[:city] = line[city]
      store_parameters[:address] = line[address]
      store_parameters[:major_type_id] = major_type.id
      store_parameters[:minor_type_id] = minor_type.id
      store = generate_store_by_params(store_parameters)
      store.save

      detail_parameters = Hash.new
      detail_parameters[:store_id] = store.id
      detail_parameters[:other_info_1] = line[info1]
      detail_parameters[:other_info_2] = line[info2]
      detail_parameters[:other_info_3] = line[info3]
      detail_parameters[:other_info_4] = line[info4]
      detail_parameters[:other_info_5] = line[info5]
      detail = generate_detail_by_params(detail_parameters)
      detail.save
    end
  end

  def generate_store_by_params(parameters)
    Store.new(:name => parameters[:name], 
              :city => parameters[:city], 
              :address => parameters[:address], 
              :major_type_id => parameters[:major_type_id], 
              :minor_type_id => parameters[:minor_type_id],
              :parse_json_id => @last_parse_json.id)
  end

  def generate_detail_by_params(parameters)
    Detail.new(:store_id => parameters[:store_id],
               :icon_url => parameters[:icon_url],
               :image_url_1 => parameters[:image_url_1],
               :image_url_2 => parameters[:image_url_2],
               :image_url_3 => parameters[:image_url_3],
               :web_address => parameters[:web_address],
               :open_time => parameters[:open_time],
               :introduction => parameters[:introduction],
               :other_info_1 => parameters[:other_info_1],
               :other_info_2 => parameters[:other_info_2],
               :other_info_3 => parameters[:other_info_3],
               :other_info_4 => parameters[:other_info_4],
               :other_info_5 => parameters[:other_info_5])
  end

  def parse_json_params
    params.require(:parse_json).permit(:name, :address, :major_type_id, :minor_type_id)
  end  
end