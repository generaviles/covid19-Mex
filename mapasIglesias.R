# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf.html
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf-2.html
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf-3.html

# Cargando Librerías ####
library("ggplot2")
theme_set(theme_bw())
library("sf")                
library("rnaturalearth")
library("rnaturalearthdata")
library("rgdal")

# Cargando Shapefiles Necesarios ####
municipios <-readOGR('data/SHP/bc_municipio.shp')
manzanas <- readOGR('data/SHP/bc_localidad_urbana_y_rural_amanzanada.shp')
municipios <- st_as_sf(municipios)
manzanas <- st_as_sf(manzanas)

# Iglesias Ensenada ####
iglesia <- c('Calle 14', 'Piedras Negras', '17 de Abril','Morelos','Indeco','Colonia 89','Playas de Chapultepec','Maneadero','Buena Vista',
             'Costa Azul','El Sauzal','Todos Santos','San Quintín','Camalu','Valle de la Trinidad','San Felipe')
distrito <- c('Ensenada 14', 'Costa Azul', 'Costa Azul', 'Costa Azul', 'Costa Azul', 'Costa Azul', 'Maneadero', 'Maneadero', 'Maneadero',
              'Costa Azul','Ensenada 14','Maneadero','San Quintín','San Quintín','Valle de la Trinidad','Valle de la Trinidad')
lat <- c(31.8760202,31.876818,31.8743797,31.8539411,31.8946976,31.8968171,31.7845418,31.7145139,31.6722148,31.8496092,31.9067437,31.7746154,
         30.5591031,30.8418155,31.3968173,31.0318284)
long <- c(-116.6194198,-116.6008716,-116.5653826,-116.565834,-116.5768868,-116.563828,-116.608876,-116.5718273,-116.5120438,-116.600647,-116.7116261,
          -116.5640298,-115.943025,-116.0621452,-115.7213545,-114.8393154)
ensenadaIgls <- data.frame(iglesia,distrito,lat,long)

# Iglesias Mexicali ####
library(readxl)
mexicaliIgls <- read_excel("data/iglesiasBC.xlsx", 
                       sheet = "Mexicali")
# Iglesias Tijuana ####
tijuanaIgls <- read_excel("data/iglesiasBC.xlsx", 
                       sheet = "Tijuana")
##### Visualizaciones ####
world <- ne_countries(scale = "medium", returnclass = "sf")

#### Ensenada ####
ggplot(data = world) +
  geom_sf(data = municipios, fill = 'moccasin', color = gray(.5)) +
  geom_sf(data = manzanas, fill = 'indianred1', color = gray(.3)) +
  geom_point(data = ensenadaIgls, aes(x = long, y = lat, fill = distrito), size = 2, 
             shape = 23) +
  #geom_text(data = ensenadaIgls, aes(x = long, y = lat, label = iglesia), 
  #          size = .9, col = "black", fontface = "bold") +
  #coord_sf(xlim = c(-117.5,-115.5), ylim = c(31.5,33), expand = FALSE)
  coord_sf(xlim = c(-116.8,-116.5), ylim = c(31.65,32), expand = FALSE)

#### Tijuana ####
ggplot(data = world) +
  geom_sf(data = municipios, fill = 'moccasin', color = gray(.5)) +
  geom_sf(data = manzanas, fill = 'indianred1', color = gray(.3)) +
  geom_point(data = tijuanaIgls, aes(x = long, y = lat, fill = Distrito), size = 2, 
             shape = 23) +
  #geom_text(data = ensenadaIgls, aes(x = long, y = lat, label = iglesia), 
  #          size = .9, col = "black", fontface = "bold") +
  #coord_sf(xlim = c(-117.5,-115.5), ylim = c(31.5,33), expand = FALSE)
  coord_sf(xlim = c(-117.15,-116.5), ylim = c(32.3,32.6), expand = FALSE) +
  theme(legend.position="bottom")

#### Mexicali ####
ggplot(data = world) +
  geom_sf(data = municipios, fill = 'moccasin', color = gray(.5)) +
  geom_sf(data = manzanas, fill = 'indianred1', color = gray(.3)) +
  geom_point(data = mexicaliIgls, aes(x = long, y = lat, fill = Distrito), size = 2, 
             shape = 23) +
  #geom_text(data = ensenadaIgls, aes(x = long, y = lat, label = iglesia), 
  #          size = .9, col = "black", fontface = "bold") +
  #coord_sf(xlim = c(-117.5,-115.5), ylim = c(31.5,33), expand = FALSE)
  coord_sf(xlim = c(-115.65,-114.7), ylim = c(32.15,32.7), expand = FALSE) +
  theme(legend.position="bottom")