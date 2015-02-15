class ParseJsonController < ApplicationController
    # 縣市
    # 字號
    # 執照類別
    # 狀態
    # 機構名稱
    # 負責獸醫
    # 發照日期
    # 機構地址
  def transfor_address
    # address = params[:transfor]
    # address = address[:address]
    address_s = "http://data.coa.gov.tw/Service/OpenData/DataFileService.aspx?UnitId=078&$filter=縣市+like+台北市"
    # address_s2 = "http://maps.google.com/maps/api/geocode/json?sensor=false&address=#{address}"
    address = URI.escape(address_s)
    address = Net::HTTP.get(URI.parse(address))    
    user_data = JSON.parse(address)
    users = []

    major_desc = "醫療"
    minor_desc = "動物"

    name = "機構名稱"
    city = "縣市"
    address = "機構地址"
    info1 = "字號"
    info2 = "執照類別 "
    info3 = "狀態"
    info4 = "負責獸醫"
    info5 = "發照日期"
    
    if MajorType.find_by_type_description(major_desc)
        major_type = MajorType.find_by_type_description(major_desc)
    else
        major_type = generate_major_with_desc(major_desc)
        major_type.save
    end

    if MinorType.where("type_description = ? AND major_type_id = ?",minor_desc , major_type.id).count > 0
        minor_type = MinorType.where("type_description = ? AND major_type_id = ?",minor_desc , major_type.id).first
    else
        minor_type = generate_minor_with_desc_and_major(minor_desc, major_type)
        minor_type.save
    end

    user_data.map do |line|
        store = Store.new(:name => line[name], :city => line[city], :address => line[address], :major_type_id => major_type.id, :minor_type_id => minor_type.id)
        store.save

        parameters = Hash.new
        parameters[:store_id] = store.id
        parameters[:other_info_1] = line[info1]
        parameters[:other_info_2] = line[info2]
        parameters[:other_info_3] = line[info3]
        parameters[:other_info_4] = line[info4]
        parameters[:other_info_5] = line[info5]
        detail = generate_detail_by_params(parameters)
        detail.save
    end
    redirect_to root_path 
  end

  private
  def generate_major_with_desc(desc)
    major_type = MajorType.new(:type_description => desc)
  end
  def generate_minor_with_desc_and_major(desc, major)
    major_type = MinorType.new(:type_description => desc, :major_type_id => major.id)
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
end