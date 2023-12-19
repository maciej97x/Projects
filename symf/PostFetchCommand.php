<?php
// src/Command/PostFetchCommand.php

namespace App\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\HttpClient\HttpClient;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Post;

class PostFetchCommand extends Command
{
    protected static $defaultName = 'app:fetch-posts';

    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->entityManager = $entityManager;
    }

    protected function configure()
    {
        $this
            ->setDescription('Fetch posts from API and save to database');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $httpClient = HttpClient::create();
        $postsData = $httpClient->request('GET', 'https://jsonplaceholder.typicode.com/posts')->toArray();
        $usersData = $httpClient->request('GET', 'https://jsonplaceholder.typicode.com/users')->toArray();

        foreach ($postsData as $postData) {
            // Przetwarzanie danych i zapis do bazy danych
            $post = new Post();
            $post->setTitle($postData['title']);
            $post->setBody($postData['body']);

            // Przykładowe połączenie postów z użytkownikami (wybierz odpowiedniego użytkownika)
            $userId = $postData['userId'];
            foreach ($usersData as $userData) {
                if ($userData['id'] === $userId) {
                    $post->setAuthor($userData['name']);
                    break;
                }
            }

            $this->entityManager->persist($post);
        }

        $this->entityManager->flush();

        $output->writeln('Posts fetched and saved to database successfully.');

        return Command::SUCCESS;
    }
}
