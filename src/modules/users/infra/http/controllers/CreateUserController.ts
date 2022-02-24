import { Request, Response } from "express";
import { CreateUserUseCase } from "../../../useCases/CreateUserUseCase";


export class CreateUserController {
  async handle(request: Request, response: Response) {
    const { name } = request.body;

    const createUserUseCase = new CreateUserUseCase();

    const result = await createUserUseCase.execute({
      name,
    });

    return response.json(result);
  }
}