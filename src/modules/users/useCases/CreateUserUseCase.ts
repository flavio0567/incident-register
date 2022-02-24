import { Users } from "@prisma/client";
import { prisma } from "../../../shared/infra/prisma/primaClient";

interface ICreateUser {
  name: string;
}
export class CreateUserUseCase {
  async execute({ name }: ICreateUser) {

    // check if user exist
    const clientExist: Users | null = await prisma.users.findFirst({
      where: {
        name: {
          contains: name
        }
      }
    })

    if (clientExist) {
      throw new Error("User already exists")
    }

    // save user
    const user = await prisma.users.create({
      data: {
        name,
      }
    });

    return user;
  }
}