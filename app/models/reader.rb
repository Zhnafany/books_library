require 'RMagick'
require 'rubygems'

class Reader < ActiveRecord::Base
  has_many :payments
  has_many :checklists
  has_one :contact
  belongs_to :faculty
  belongs_to :educational_institution
  belongs_to :benefit
  belongs_to :status
  belongs_to :category
  belongs_to :degree

  validates_columns :document_type
  validates_presence_of [:name, :surname, :father_name, :document_num],
                      :message => "відстуне"
  validates_format_of :name, :with => /[а-яА-ЯІЇЄєії]+$/,
                      :message => "повинно мати тільки кирилицю"
  validates_format_of :surname, :with => /[а-яА-ЯІЇЄєії]+$/,
                      :message => "повинна мати тільки кирилицю"
  validates_format_of :father_name, :with => /[а-яА-ЯІЇЄєії]+$/,
                      :message => "повинно мати тільки кирилицю"

  def self.photos_directory
    @@photos_directory = 'public/readers_photos'
  end

  def photo_path
    "/readers_photos/" + self.id.to_s + ".jpg"
  end


  def generateReaderTicket
    canvas = Magick::Image.new(300, 450) {
      self.background_color = '#ffffff'
    }
    logo = Magick::ImageList.new("public/images/reader_ticket_logo.jpg")
    logo.resize!(270, 215)
    logo.crop!(0, 0, 280, 210)
    logo.rotate!(180)

    info_side = Magick::Image.new(300, 210) {
      self.background_color = '#ffffff'
    }

    begin
      photo = Magick::ImageList.new("public/readers_photos/#{self.id}.jpg")
    rescue Exception
      photo = Magick::ImageList.new("public/images/no_foto.jpg")
    end
    photo.resize!(100, 140)

    canvas = canvas.composite(logo, Magick::NorthGravity, Magick::CopyCompositeOp)
    info_side = info_side.composite(photo, 10, 30, Magick::CopyCompositeOp)

    draw = Magick::Draw.new
    draw.annotate(info_side, 0, 0, 0, 180, "Читацький квиток № #{self.id}") {
      self.gravity = Magick::SouthGravity
      self.pointsize = 18
      self.stroke = 'transparent'
      self.fill = '#000000'
      self.font_weight = Magick::BoldWeight
    }
    draw.font_family('times')
    draw.font_style(Magick::ObliqueStyle)
    draw.gravity(Magick::SouthWestGravity)
    xPoint = 190
    draw.pointsize(19)
    draw.text_align(Magick::CenterAlign)
    draw.text(xPoint, 80, self.surname)
    draw.text(xPoint, 110, self.name)
    draw.text(xPoint, 140, self.father_name)

    draw.line(0, 2, 30, 2)
    draw.line(270, 2, 300, 2)

    draw.fill('#ffffff')
    draw.stroke('#ff5240')
    draw.stroke_width(2)
    draw.roundrectangle(10, 175, 50, 205, 8, 8 )

    draw.fill_opacity(0)
    draw.ellipse(250, 190, 40, 15, 0, 360)

    draw.fill('#ff5240')
    draw.stroke_width(1)
    draw.text(30, 195, self.category.code)
    draw.text(250, 195, Date.today.year.to_s)

    draw.draw(info_side)

    mark = Magick::Image.new(180, 150) do
      self.background_color = 'none'
    end
    gc = Magick::Draw.new
    gc.annotate(mark, 0, 0, 0, 0, "Обласна") do
      self.gravity = Magick::CenterGravity
      self.pointsize = 18
      self.fill = "#000000"
      self.font_weight = 100
      self.font_stretch = Magick::ExtraExpandedStretch
    end
    gc.annotate(mark, 0, 0, 0, 25, "Унiверсальна")
    gc.annotate(mark, 0, 0, 0, 50, "Наукова Бiблiотека")
    mark.rotate!(-25)

    info_side = info_side.watermark(mark, 0.30, 0, Magick::SouthEastGravity)

    canvas = canvas.composite( info_side, 0, 210, Magick::CopyCompositeOp)

    canvas.write("public/images/curent_reader_ticket.png")
  end

  def FotoExist?
    begin
      photo = Magick::ImageList.new("public/readers_photos/#{self.id}.jpg")
    rescue Exception
      photo = nil
    end
    photo
  end

end
