import MemoryCache
import bitarray

'''
O mais recentemente usado fica com 1
'''

class LRU(object):
    def __init__(self, cache, block, label):
        self.cache = cache  # Recebe um objeto do tipo cache
        self.block = block
        self.label = label

    def verificacoes(self, quadroA, label):
        # Verifica se está na cache
        if self.label == self.cache.lines[quadroA].label:
            aux = self.cache.lines[]

        if self.label == self.cache.lines[quadroB].label:
            aux = self.cache.lines[]