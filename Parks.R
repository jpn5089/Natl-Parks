library(dplyr)
library(xlsx)

parks <- read.xlsx("C://Users/John/Documents/GitHub/Nat'l_Parks/locations.xlsx", sheetIndex = 1) %>%
  rename(Lat = `Lat.`)

bbox <- make_bbox(parks$Lon, parks$Lat, f = 0.01)
map <- get_map(bbox)

ggmap(map) +
  geom_point(data=parks, aes(x = Lon, y = Lat, col = Visited)) +
  geom_label_repel(data = parks[parks$Visited == 'Yes',], aes(x = Lon, y = Lat, label = Park), 
                   size = 2.5,
                   box.padding = unit(0.75, "lines"),
                   point.padding = unit(0.2, "lines"),
                   arrow = arrow(length = unit(0.01, 'npc')),
                   segment.color = "black", segment.size = 1) +
  labs(x = "Longitude", y = "Latitude", title = "The Quest for all 59", subtitle = "Source: http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.subtitle = element_text(hjust = 0.5)) 
ggsave(filename = "C:\\Users\\John\\Desktop\\Parks.jpeg", width = 10, height = 7)

