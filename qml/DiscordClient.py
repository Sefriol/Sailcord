import discord
import asyncio
import pyotherside

def run(email, password):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    client = discord.Client(loop=loop)

    @client.event
    @asyncio.coroutine
    def on_ready():
        servers = list(map(lambda s: s.name, client.servers))
        pyotherside.send('Discord-Status', 'Logged in as\n{name},\n{id}\n------\n{servers}'.format(name=client.user.name, id=client.user.id,servers=servers))
        pyotherside.send('Discord-Servers', list(map(lambda s: {'name': s.name}, client.servers)))

    @client.event
    @asyncio.coroutine
    def on_message(message):
        pyotherside.send('Discord-Message', 'received a message in {message.server}#{message.channel} by {message.author.name},\n'.format(message=message))
        if message.content.startswith('!test'):
            counter = 0
            tmp = yield from client.send_message(message.channel, 'Calculating messages...')
            channel_messages = yield from client.logs_from(message.channel, limit=100)
            for log in channel_messages:
                if log.author == message.author:
                    counter += 1

            yield from client.edit_message(tmp, 'You have {} messages.'.format(counter))
        elif message.content.startswith('!sleep'):
            yield from asyncio.sleep(5)
            yield from client.send_message(message.channel, 'Done sleeping')
    client.run(email, password)


