from pygame import *


class GameSprite(sprite.Sprite):
    def __init__(self, sprite_image, size_x, size_y, player_x, player_y, player_speed):
        sprite.Sprite.__init__(self)
        self.image = transform.scale(image.load(sprite_image), (size_x, size_y))
        self.rect = self.image.get_rect()
        self.rect.x = player_x
        self.rect.y = player_y
        self.speed = player_speed

    def draw(self):
        window.blit(self.image, (self.rect.x, self.rect.y))

class Player(GameSprite):
    def updater(self):
        keys = key.get_pressed()
        if keys[K_UP] and self.rect.y > 5:
            self.rect.y -= self.speed
        if keys[K_DOWN] and self.rect.y < 420:
            self.rect.y += self.speed

    def updatel(self):
        keys = key.get_pressed()
        if keys[K_w] and self.rect.y > 5:
            self.rect.y -= self.speed
        if keys[K_s] and self.rect.y < 420:
            self.rect.y += self.speed

playerr = Player('racket.png', 50, 150, 520, 200, 5)
playerl = Player('racket.png', 50, 150, 30, 200, 5)
ball = GameSprite('tenis_ball.png', 50, 50, 200, 200, 5)

window = display.set_mode((600,500))
display.set_caption('Shooter')

window.fill((200,255,255))

clock = time.Clock()

speed_x = 3
speed_y = 3

font.init()
font = font.Font(None, 35)
lose1 = font.render('PLAYER 1 LOSE!', True, (180, 0, 0))
lose2 = font.render('PLAYER 2 LOSE!', True, (180, 0, 0))

while True:
    window.fill((200, 255, 255))

    ball.rect.x += speed_x
    ball.rect.y += speed_y

    if sprite.collide_rect(playerr, ball) or sprite.collide_rect(playerl, ball):
        speed_x *= -1

    if ball.rect.y > 500 - 50 or ball.rect.y < 0:
        speed_y *= -1

    if ball.rect.x < 0:
        window.blit(lose1, (200, 200))

    if ball.rect.x > 500:
        window.blit(lose2, (200, 200))

    playerr.draw()
    playerl.draw()
    ball.draw()
    playerr.updater()
    playerl.updatel()

    for e in event.get():
        if e.type == QUIT:
            sys.exit()

    clock.tick(60)
    display.update()
