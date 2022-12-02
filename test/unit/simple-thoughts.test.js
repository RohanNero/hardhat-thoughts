const { assert, expect } = require("chai")
const { network, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

!developmentChains.includes(network.name)
  ? describe.skip
  : describe("simple thoughts unit tests", function () {
      let deployer, user, simpleThoughts
      beforeEach(async function () {
        ;[deployer, user] = await ethers.getSigners()
        const thoughtFactory = await ethers.getContractFactory(
          "SimpleThoughts",
          deployer
        )
        simpleThoughts = await thoughtFactory.deploy()
      })
      describe("constructor", function () {
        it("should set owner address correctly", async function () {
          const value = await simpleThoughts.owner()
          assert.equal(deployer.address, value)
        })
      })
      describe("shareThought", function () {
        it("reverts if msg.sender isnt owner", async function () {
          await expect(
            simpleThoughts.connect(user).shareThought("amor fati")
          ).to.be.revertedWithCustomError(
            simpleThoughts,
            "SimpleThoughts__InvalidAddress"
          )
        })
        it("pushes new thought to thoughtArray", async function () {
          await simpleThoughts.shareThought("malo mori quam foedari")
          const value = await simpleThoughts.thoughtArray(0)
          assert.equal(value.thought, "malo mori quam foedari")
        })
        it("emits ThoughtShared event correctly", async function () {
          await expect(simpleThoughts.shareThought("malo mori quam foedari"))
            .to.emit(simpleThoughts, "ThoughtShared")
            .withArgs(0, deployer.address)
        })
      })
      describe("changeOwner", function () {
        it("reverts if msg.sender isnt the owner", async function () {
          await expect(
            simpleThoughts.connect(user).changeOwner(user.address)
          ).to.be.revertedWithCustomError(
            simpleThoughts,
            "SimpleThoughts__InvalidAddress"
          )
        })
        // making contract as simple and cheap as possible, so users may change owner address to the current one at their own expense
        // it("reverts if newOwner address is equal to old address", async function () {
        //     await expect(
        //         simpleThoughts.connect(user).shareThought("amor fati")
        //       ).to.be.revertedWithCustomError(
        //         simpleThoughts,
        //         "SimpleThoughts__InvalidAddress"
        //       )
        // })
        it("changes owner address correctly", async function () {
          await simpleThoughts.changeOwner(user.address)
          await expect(
            simpleThoughts.shareThought("amor fati")
          ).to.be.revertedWithCustomError(
            simpleThoughts,
            "SimpleThoughts__InvalidAddress"
          )
        })
        it("emits OwnerChanged event correctly", async function () {
          await expect(simpleThoughts.changeOwner(user.address))
            .to.emit(simpleThoughts, "OwnerChanged")
            .withArgs(deployer.address, user.address)
        })
      })
    })
