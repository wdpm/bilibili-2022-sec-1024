# Palkeoramix decompiler.

const getBalance = eth.balance(this.address)
const decimals = 18

def storage:
  _balances is mapping of uint256 at storage 0
  unknown453cb2e6 is mapping of uint256 at storage 1
  unknownad7a04c0 is mapping of uint256 at storage 2
  allowance is mapping of uint256 at storage 3
  unknownb2adf8a1 is mapping of uint256 at storage 4
  unknownc19263e7 is mapping of uint256 at storage 5
  unknown9d44988a is mapping of uint256 at storage 6
  unknown0bb1e8a0 is mapping of uint256 at storage 7
  unknown48e26bfe is mapping of uint256 at storage 8
  unknown8f988946 is mapping of uint256 at storage 9
  totalSupply is uint256 at storage 10
  stor11 is array of struct at storage 11
  stor12 is array of struct at storage 12
  stor13 is addr at storage 13
  stor14 is addr at storage 14
  unknown59c32e40 is uint256 at storage 15
  _price is uint256 at storage 16
  stor17 is uint256 at storage 17
  stor18 is uint256 at storage 18
  stor19 is addr at storage 19
  stor20 is array of struct at storage 20
  unknowndb50be82Address is addr at storage 21
  unknown8c50c9d1Address is addr at storage 22

def unknown0bb1e8a0(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown0bb1e8a0[_param1]

def get_price() payable:
  return _price

def totalSupply() payable:
  return totalSupply

def unknown453cb2e6(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown453cb2e6[_param1]

def unknown48e26bfe(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown48e26bfe[_param1]

def unknown59c32e40() payable:
  require caller == stor13
  return unknown59c32e40

def _balances(address _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  return _balances[_param1]

def balanceOf(address _owner) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _owner == _owner
  return _balances[addr(_owner)]

def unknown8c50c9d1() payable:
  return unknown8c50c9d1Address

def unknown8f988946(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown8f988946[_param1]

def unknown9d44988a(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknown9d44988a[_param1]

def unknownad7a04c0(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknownad7a04c0[_param1]

def unknownb2adf8a1(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknownb2adf8a1[_param1]

def unknownc19263e7(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == addr(_param1)
  return unknownc19263e7[_param1]

def unknowndb50be82() payable:
  return unknowndb50be82Address

def allowance(address _owner, address _spender) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _owner == _owner
  require _spender == _spender
  return allowance[addr(_owner)][addr(_spender)]

#
#  Regular functions
#

def _fallback() payable: # default function
  revert

def unknownab0cc77b() payable:
  require caller == stor13
  stor13 = stor14

def unknown8e2a219e(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  require caller == stor13
  unknown59c32e40 = _param1
  log 0x9e768e86: _param1

def deposit() payable:
  if unknown8f988946[caller]:
      revert with 0, 'you can only deposit once'
  unknown8f988946[caller] = 1
  if unknownad7a04c0[caller] > -2:
      revert with 'NH{q', 17
  unknownad7a04c0[caller]++

def unknown2ad044b9() payable:
  require caller == stor13
  if not stor13:
      revert with 0, 'ERC20: mint to the zero address'
  if totalSupply > -1001:
      revert with 'NH{q', 17
  totalSupply += 1000
  _balances[stor13] += 1000
  log Transfer(
        address from=1000,
        address to=0,
        uint256 tokens=stor13)

def withdraw() payable:
  require unknownad7a04c0[caller] >= 1
  require unknown453cb2e6[caller] >= 1812
  call caller with:
     value 10^17 wei
       gas gas_remaining wei
  unknown453cb2e6[caller] = 0
  if unknown48e26bfe[caller] > -2:
      revert with 'NH{q', 17
  unknown48e26bfe[caller]++

def unknown05aad32d(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  if _param1 != unknown59c32e40:
      revert with 0, 'auth fail'
  if unknown9d44988a[caller]:
      revert with 0, 'already authd'
  if unknownc19263e7[caller] > -2:
      revert with 'NH{q', 17
  unknownc19263e7[caller]++
  if unknown9d44988a[caller] > -2:
      revert with 'NH{q', 17
  unknown9d44988a[caller]++

def unknown195076ec(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  if block.number < 1:
      revert with 'NH{q', 17
  if sha3(block.hash(block.number - 1), block.timestamp) != _param1:
      revert with 0, 'password error, auth fail'
  if unknownc19263e7[caller] != 1:
      revert with 0, 'need pre auth'
  if unknown9d44988a[caller] != 1:
      revert with 0, 'already authd'
  if unknown9d44988a[caller] > -2:
      revert with 'NH{q', 17
  unknown9d44988a[caller]++

def approve(address _spender, uint256 _value) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _spender == _spender
  require _value == _value
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve from the zero address'
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve to the zero address'
  allowance[caller][addr(_spender)] = _value
  log Approval(
        address tokenOwner=_value,
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def profit() payable:
  require not unknownb2adf8a1[caller]
  if unknownb2adf8a1[caller] > -2:
      revert with 'NH{q', 17
  unknownb2adf8a1[caller]++
  if not stor13:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[stor13] < 1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[stor13]--
  _balances[caller]++
  log Transfer(
        address from=1,
        address to=stor13,
        uint256 tokens=caller)

def transfer(address _to, uint256 _value) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _to == _to
  require _value == _value
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[caller] < _value:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[caller] -= _value
  _balances[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=caller,
        uint256 tokens=_to)
  return 1

def increaseAllowance(address _spender, uint256 _addedValue) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _spender == _spender
  require _addedValue == _addedValue
  require caller == stor13
  if allowance[caller][addr(_spender)] > -_addedValue - 1:
      revert with 'NH{q', 17
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve from the zero address'
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve to the zero address'
  allowance[caller][addr(_spender)] += _addedValue
  log Approval(
        address tokenOwner=(allowance[caller][addr(_spender)] + _addedValue),
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def borrow(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  require _param1 == 1
  require unknownb2adf8a1[caller] <= 1
  if unknownb2adf8a1[caller] > -2:
      revert with 'NH{q', 17
  unknownb2adf8a1[caller]++
  if not stor13:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[stor13] < _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[stor13] -= _param1
  _balances[caller] += _param1
  log Transfer(
        address from=_param1,
        address to=stor13,
        uint256 tokens=caller)

def decreaseAllowance(address _spender, uint256 _subtractedValue) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _spender == _spender
  require _subtractedValue == _subtractedValue
  require caller == stor13
  if allowance[caller][addr(_spender)] < _subtractedValue:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: decreased allowance below zero'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve from the zero address'
  if not _spender:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve to the zero address'
  allowance[caller][addr(_spender)] -= _subtractedValue
  log Approval(
        address tokenOwner=(allowance[caller][addr(_spender)] - _subtractedValue),
        address spender=caller,
        uint256 tokens=_spender)
  return 1

def unknown96032702(uint256 _param1) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _param1 == _param1
  if _balances[caller] < _param1:
      revert with 0, 'fail to sale'
  if _param1 and _price > -1 / _param1:
      revert with 'NH{q', 17
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not stor13:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[caller] < _param1:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[caller] -= _param1
  _balances[stor13] += _param1
  log Transfer(
        address from=_param1,
        address to=caller,
        uint256 tokens=stor13)
  if unknown453cb2e6[caller] > (-1 * _param1 * _price) - 1:
      revert with 'NH{q', 17
  unknown453cb2e6[caller] += _param1 * _price

def transferFrom(address _from, address _to, uint256 _value) payable:
  require calldata.size - 4 >=ΓÇ▓ 96
  require _from == _from
  require _to == _to
  require _value == _value
  require caller == stor13
  if allowance[addr(_from)][caller] != -1:
      if allowance[addr(_from)][caller] < _value:
          revert with 0, 'ERC20: insufficient allowance'
      if not _from:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve from the zero address'
      if not caller:
          revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: approve to the zero address'
      allowance[addr(_from)][caller] -= _value
      log Approval(
            address tokenOwner=(allowance[addr(_from)][caller] - _value),
            address spender=_from,
            uint256 tokens=caller)
  if not _from:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not _to:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[addr(_from)] < _value:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[addr(_from)] -= _value
  _balances[addr(_to)] += _value
  log Transfer(
        address from=_value,
        address to=_from,
        uint256 tokens=_to)
  return 1

def buy(uint256 _againCount) payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require _againCount_ == _againCount_
  if _againCount_ > 300:
      revert with 0, 'max buy count is 300'
  if unknown453cb2e6[caller] < 10:
      if _againCount_ and 10^6 > -1 / _againCount_:
          revert with 'NH{q', 17
      require 10^6 * _againCount_ <= unknown453cb2e6[caller]
      if unknown453cb2e6[caller] < 10^6 * _againCount_:
          revert with 'NH{q', 17
      unknown453cb2e6[caller] += -1 * 10^6 * _againCount_
  else:
      if unknown453cb2e6[caller] > 233:
          if _againCount_ and 1 > -1 / _againCount_:
              revert with 'NH{q', 17
          require _againCount_ <= unknown453cb2e6[caller]
          if unknown453cb2e6[caller] < _againCount_:
              revert with 'NH{q', 17
          unknown453cb2e6[caller] -= _againCount_
      else:
          if _againCount_ and 10000 > -1 / _againCount_:
              revert with 'NH{q', 17
          require 10000 * _againCount_ <= unknown453cb2e6[caller]
          if unknown453cb2e6[caller] < 10000 * _againCount_:
              revert with 'NH{q', 17
          unknown453cb2e6[caller] += -10000 * _againCount_
  if not stor13:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer from the zero address'
  if not caller:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer to the zero address'
  if _balances[stor13] < _againCount_:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC20: transfer amount exceeds balance'
  _balances[stor13] -= _againCount_
  _balances[caller] += _againCount_
  log Transfer(
        address from=_againCount_,
        address to=stor13,
        uint256 tokens=caller)

def unknown0dd2f134() payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require cd <= 18446744073709551615
  require calldata.size + -cd >=ΓÇ▓ 128
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(cd('cd', 4).length + 4)] == 2233
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(('cd', 4).length + cd == cd[(('cd', 4).length + cd[4] + 4)]
  require cd[(('cd', 4).length + cd == cd[(('cd', 4).length + cd[4] + 36)]
  require cd[(('cd', 4).length + cd == addr(cd[(('cd', 4).length + cd)
  require cd[(('cd', 4).length + cd <ΓÇ▓ calldata.size + -('cd', 4).length + -cd[4] - 35
  require cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd <= 18446744073709551615
  require ('cd', 4).length + cd <=ΓÇ▓ calldata.size - cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd[4] + 4)]
  mem[420 len cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd] = call.data[cd[(('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd[4] + 4)]]
  mem[cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd] = 0
  require ('cd', 4) == uint8(('cd', 4))
  require ext_code.size(this.address)
  call this.address.0x302c0dc7 with:
       gas gas_remaining wei
      args 0, 32, 128, ('cd', 4) << 248, call.data[cd('cd', 4).length + cdaddr(cd[(('cd', 4).length + cd), 128, cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cdmem[cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd len ceil32(cd[(cd[(('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd('cd', 4).length + cd]
  if not ext_call.success:
      revert with ext_call.return_data[0 len return_data.size]

def payforflag(string _param1, string _param2) payable:
  require calldata.size - 4 >=ΓÇ▓ 64
  require _param1 <= 18446744073709551615
  require _param1 + 35 <ΓÇ▓ calldata.size
  if _param1.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_param1.length)) + 97 > 18446744073709551615 or ceil32(ceil32(_param1.length)) + 97 < 96:
      revert with 'NH{q', 65
  require _param1 + _param1.length + 36 <= calldata.size
  require _param2 <= 18446744073709551615
  require _param2 + 35 <ΓÇ▓ calldata.size
  if _param2.length > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(_param1.length)) + ceil32(ceil32(_param2.length)) + 98 > 18446744073709551615 or ceil32(ceil32(_param2.length)) + 98 < 97:
      revert with 'NH{q', 65
  require _param2 + _param2.length + 36 <= calldata.size
  require unknown48e26bfe[caller] == 2
  if ceil32(_param1.length) <= _param1.length:
      log 0x6335b7f9: Array(len=_param1.length, data=Mask(8 * ceil32(_param1.length), -(8 * ceil32(_param1.length)) + 256, _param1[all], Mask(8 * ceil32(_param1.length) - _param1.length, -(8 * ceil32(_param1.length) + -ceil32(ceil32(_param1.length)) + 31) + 256, _param2.length) >> -(8 * ceil32(_param1.length) + -ceil32(ceil32(_param1.length)) + 31) + 256) << (8 * ceil32(_param1.length)) - 256, _param2.length, _param2[all], Mask(8 * ceil32(_param2.length) - _param2.length, -(8 * ceil32(_param2.length) + -ceil32(ceil32(_param2.length)) + 31) + 256, 64) >> -(8 * ceil32(_param2.length) + -ceil32(ceil32(_param2.length)) + 31) + 256), ceil32(_param1.length) + 96
  else:
      mem[ceil32(ceil32(_param1.length)) + ceil32(ceil32(_param2.length)) + ceil32(_param1.length) + 194] = _param2.length
      mem[ceil32(ceil32(_param1.length)) + ceil32(ceil32(_param2.length)) + ceil32(_param1.length) + 226 len ceil32(_param2.length)] = _param2[all], Mask(8 * ceil32(_param2.length) - _param2.length, -(8 * ceil32(_param2.length) + -ceil32(ceil32(_param2.length)) + 31) + 256, 64) >> -(8 * ceil32(_param2.length) + -ceil32(ceil32(_param2.length)) + 31) + 256
      if ceil32(_param2.length) > _param2.length:
          mem[ceil32(ceil32(_param1.length)) + ceil32(ceil32(_param2.length)) + ceil32(_param1.length) + _param2.length + 226] = 0
      log 0x6335b7f9: Array(len=_param1.length, data=Mask(8 * ceil32(_param1.length), -(8 * ceil32(_param1.length)) + 256, _param1[all], Mask(8 * ceil32(_param1.length) - _param1.length, -(8 * ceil32(_param1.length) + -ceil32(ceil32(_param1.length)) + 31) + 256, _param2.length) >> -(8 * ceil32(_param1.length) + -ceil32(ceil32(_param1.length)) + 31) + 256) << (8 * ceil32(_param1.length)) - 256, Mask(8 * -ceil32(_param1.length) + _param1.length + 32, 0, 0), mem[ceil32(ceil32(_param1.length)) + ceil32(ceil32(_param2.length)) + _param1.length + 226 len ceil32(_param2.length) - _param1.length + ceil32(_param1.length)]), ceil32(_param1.length) + 96

def c() payable:
  if bool(stor20.length):
      if bool(stor20.length) == stor20.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor20.length):
          if bool(stor20.length) == stor20.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor20.length.field_1:
              if 31 >= stor20.length.field_1:
                  mem[128] = 256 * stor20.length.field_8
              else:
                  mem[128] = uint256(stor20.field_0)
                  idx = 128
                  s = 0
                  while stor20.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor20[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
      else:
          if bool(stor20.length) == stor20.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor20.length.field_1:
              if 31 >= stor20.length.field_1:
                  mem[128] = 256 * stor20.length.field_8
              else:
                  mem[128] = uint256(stor20.field_0)
                  idx = 128
                  s = 0
                  while stor20.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor20[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
      return stor17,
             stor18,
             stor19,
             Array(len=2 * Mask(256, -1, stor20.length.field_1), data=mem[128 len ceil32(stor20.length.field_1)])
  if bool(stor20.length) == stor20.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor20.length):
      if bool(stor20.length) == stor20.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor20.length.field_1:
          if 31 >= stor20.length.field_1:
              mem[128] = 256 * stor20.length.field_8
          else:
              mem[128] = uint256(stor20.field_0)
              idx = 128
              s = 0
              while stor20.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor20[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
  else:
      if bool(stor20.length) == stor20.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor20.length.field_1:
          if 31 >= stor20.length.field_1:
              mem[128] = 256 * stor20.length.field_8
          else:
              mem[128] = uint256(stor20.field_0)
              idx = 128
              s = 0
              while stor20.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor20[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
  return stor17, stor18, stor19, Array(len=stor20.length % 128, data=mem[128 len ceil32(stor20.length.field_1)])

def unknown302c0dc7() payable:
  require calldata.size - 4 >=ΓÇ▓ 32
  require cd <= 18446744073709551615
  require calldata.size + -cd >=ΓÇ▓ 128
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  if cd[(cd('cd', 4).length + 4)]:
      revert with 0, 'loan key error'
  if this.address != caller:
      revert with 0, 'hacker get out'
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require calldata.size + -cd('cd', 4).length - 4 >=ΓÇ▓ 128
  require cd[(cd('cd', 4).length + 4)] == cd[(cd('cd', 4).length + 4)]
  require cd[(cd('cd', 4).length + 36)] == cd[(cd('cd', 4).length + 36)]
  require cd[(cd('cd', 4).length + 68)] == addr(cd[(cd('cd', 4).length + 68)])
  require cd[(cd('cd', 4).length + 100)] <= 18446744073709551615
  require cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 35 <ΓÇ▓ calldata.size
  if cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)] > 18446744073709551615:
      revert with 'NH{q', 65
  if ceil32(ceil32(cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)])) + 225 > 18446744073709551615 or ceil32(ceil32(cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)])) + 225 < 224:
      revert with 'NH{q', 65
  require cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)] + 36 <= calldata.size
  require calldata.size + -cd >=ΓÇ▓ 96
  if not bool(ceil32(ceil32(cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)])) + 289 <= 18446744073709551615):
      revert with 'NH{q', 65
  require ('cd', 4) == uint8(('cd', 4))
  require cd <ΓÇ▓ calldata.size
  if not bool(ceil32(ceil32(cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)])) + 353 <= 18446744073709551615):
      revert with 'NH{q', 65
  require cd <= calldata.size
  idx = cd[4] + 68
  s = ceil32(ceil32(cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)])) + 289
  while idx < cd:
      require cd[idx] == cd[idx]
      mem[s] = cd[idx]
      idx = idx + 32
      s = s + 32
      continue
  stor17 = cd[(cd('cd', 4).length + 4)]
  stor18 = cd[(cd('cd', 4).length + 36)]
  stor19 = addr(cd[(cd('cd', 4).length + 68)])
  if bool(stor20.length):
      if bool(stor20.length) == stor20.length.field_1 < 32:
          revert with 'NH{q', 34
      if cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)]:
          stor20[].field_0 = Array(len=cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)], data=call.data[cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 36 len cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)]])
      else:
          stor20.length = 0
          idx = 0
          while stor20.length.field_1 + 31 / 32 > idx:
              stor20[idx].field_0 = 0
              idx = idx + 1
              continue
  else:
      if bool(stor20.length) == stor20.length.field_1 < 32:
          revert with 'NH{q', 34
      if cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)]:
          stor20[].field_0 = Array(len=cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)], data=call.data[cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 36 len cd[(cd('cd', 4).length + cd[(cd('cd', 4).length + 100)] + 4)]])
      else:
          stor20.length = 0
          idx = 0
          while stor20.length.field_1 + 31 / 32 > idx:
              stor20[idx].field_0 = 0
              idx = idx + 1
              continue
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(cd('cd', 4).length + 68)] == addr(cd[(cd('cd', 4).length + 68)])
  if unknown9d44988a[addr(cd[(cd('cd', 4).length + 68)])] != 2:
      revert with 0, 'need pre auth'
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(cd('cd', 4).length + 68)] == addr(cd[(cd('cd', 4).length + 68)])
  if unknown0bb1e8a0[addr(cd[(cd('cd', 4).length + 68)])]:
      revert with 0, 'you have already loaned'
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  if cd[(cd('cd', 4).length + 36)] > 300:
      revert with 0, 'loan amount error'
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(cd('cd', 4).length + 68)] == addr(cd[(cd('cd', 4).length + 68)])
  unknown0bb1e8a0[addr(cd[(cd('cd', 4).length + 68)])] = 1
  require ('cd', 4).length <ΓÇ▓ calldata.size + -cd[4] - 131
  require cd[(cd('cd', 4).length + 68)] == addr(cd[(cd('cd', 4).length + 68)])
  if unknown453cb2e6[addr(cd[(cd('cd', 4).length + 68)])] > -cd[(cd('cd', 4).length + 36)] - 1:
      revert with 'NH{q', 17
  unknown453cb2e6[addr(cd[(cd('cd', 4).length + 68)])] += cd[(cd('cd', 4).length + 36)]

def name() payable:
  if bool(stor11.length):
      if bool(stor11.length) == stor11.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor11.length):
          if bool(stor11.length) == stor11.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor11.length.field_1:
              if 31 < stor11.length.field_1:
                  mem[128] = uint256(stor11.field_0)
                  idx = 128
                  s = 0
                  while stor11.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor11[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
                  return Array(len=2 * Mask(256, -1, stor11.length.field_1), data=mem[128 len ceil32(stor11.length.field_1)])
              mem[128] = 256 * stor11.length.field_8
      else:
          if bool(stor11.length) == stor11.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor11.length.field_1:
              if 31 < stor11.length.field_1:
                  mem[128] = uint256(stor11.field_0)
                  idx = 128
                  s = 0
                  while stor11.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor11[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
                  return Array(len=2 * Mask(256, -1, stor11.length.field_1), data=mem[128 len ceil32(stor11.length.field_1)])
              mem[128] = 256 * stor11.length.field_8
      mem[ceil32(stor11.length.field_1) + 192 len ceil32(stor11.length.field_1)] = mem[128 len ceil32(stor11.length.field_1)]
      if ceil32(stor11.length.field_1) > stor11.length.field_1:
          mem[ceil32(stor11.length.field_1) + stor11.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor11.length.field_1), data=mem[128 len ceil32(stor11.length.field_1)], mem[(2 * ceil32(stor11.length.field_1)) + 192 len 2 * ceil32(stor11.length.field_1)]),
  if bool(stor11.length) == stor11.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor11.length):
      if bool(stor11.length) == stor11.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor11.length.field_1:
          if 31 < stor11.length.field_1:
              mem[128] = uint256(stor11.field_0)
              idx = 128
              s = 0
              while stor11.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor11[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
              return Array(len=stor11.length % 128, data=mem[128 len ceil32(stor11.length.field_1)])
          mem[128] = 256 * stor11.length.field_8
  else:
      if bool(stor11.length) == stor11.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor11.length.field_1:
          if 31 < stor11.length.field_1:
              mem[128] = uint256(stor11.field_0)
              idx = 128
              s = 0
              while stor11.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor11[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
              return Array(len=stor11.length % 128, data=mem[128 len ceil32(stor11.length.field_1)])
          mem[128] = 256 * stor11.length.field_8
  mem[ceil32(stor11.length.field_1) + 192 len ceil32(stor11.length.field_1)] = mem[128 len ceil32(stor11.length.field_1)]
  if ceil32(stor11.length.field_1) > stor11.length.field_1:
      mem[ceil32(stor11.length.field_1) + stor11.length.field_1 + 192] = 0
  return Array(len=stor11.length % 128, data=mem[128 len ceil32(stor11.length.field_1)], mem[(2 * ceil32(stor11.length.field_1)) + 192 len 2 * ceil32(stor11.length.field_1)]),

def symbol() payable:
  if bool(stor12.length):
      if bool(stor12.length) == stor12.length.field_1 < 32:
          revert with 'NH{q', 34
      if bool(stor12.length):
          if bool(stor12.length) == stor12.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor12.length.field_1:
              if 31 < stor12.length.field_1:
                  mem[128] = uint256(stor12.field_0)
                  idx = 128
                  s = 0
                  while stor12.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor12[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
                  return Array(len=2 * Mask(256, -1, stor12.length.field_1), data=mem[128 len ceil32(stor12.length.field_1)])
              mem[128] = 256 * stor12.length.field_8
      else:
          if bool(stor12.length) == stor12.length.field_1 < 32:
              revert with 'NH{q', 34
          if stor12.length.field_1:
              if 31 < stor12.length.field_1:
                  mem[128] = uint256(stor12.field_0)
                  idx = 128
                  s = 0
                  while stor12.length.field_1 + 96 > idx:
                      mem[idx + 32] = stor12[s].field_256
                      idx = idx + 32
                      s = s + 1
                      continue
                  return Array(len=2 * Mask(256, -1, stor12.length.field_1), data=mem[128 len ceil32(stor12.length.field_1)])
              mem[128] = 256 * stor12.length.field_8
      mem[ceil32(stor12.length.field_1) + 192 len ceil32(stor12.length.field_1)] = mem[128 len ceil32(stor12.length.field_1)]
      if ceil32(stor12.length.field_1) > stor12.length.field_1:
          mem[ceil32(stor12.length.field_1) + stor12.length.field_1 + 192] = 0
      return Array(len=2 * Mask(256, -1, stor12.length.field_1), data=mem[128 len ceil32(stor12.length.field_1)], mem[(2 * ceil32(stor12.length.field_1)) + 192 len 2 * ceil32(stor12.length.field_1)]),
  if bool(stor12.length) == stor12.length.field_1 < 32:
      revert with 'NH{q', 34
  if bool(stor12.length):
      if bool(stor12.length) == stor12.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor12.length.field_1:
          if 31 < stor12.length.field_1:
              mem[128] = uint256(stor12.field_0)
              idx = 128
              s = 0
              while stor12.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor12[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
              return Array(len=stor12.length % 128, data=mem[128 len ceil32(stor12.length.field_1)])
          mem[128] = 256 * stor12.length.field_8
  else:
      if bool(stor12.length) == stor12.length.field_1 < 32:
          revert with 'NH{q', 34
      if stor12.length.field_1:
          if 31 < stor12.length.field_1:
              mem[128] = uint256(stor12.field_0)
              idx = 128
              s = 0
              while stor12.length.field_1 + 96 > idx:
                  mem[idx + 32] = stor12[s].field_256
                  idx = idx + 32
                  s = s + 1
                  continue
              return Array(len=stor12.length % 128, data=mem[128 len ceil32(stor12.length.field_1)])
          mem[128] = 256 * stor12.length.field_8
  mem[ceil32(stor12.length.field_1) + 192 len ceil32(stor12.length.field_1)] = mem[128 len ceil32(stor12.length.field_1)]
  if ceil32(stor12.length.field_1) > stor12.length.field_1:
      mem[ceil32(stor12.length.field_1) + stor12.length.field_1 + 192] = 0
  return Array(len=stor12.length % 128, data=mem[128 len ceil32(stor12.length.field_1)], mem[(2 * ceil32(stor12.length.field_1)) + 192 len 2 * ceil32(stor12.length.field_1)]),


