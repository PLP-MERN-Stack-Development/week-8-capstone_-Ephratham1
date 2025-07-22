"use client"

import { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import { Search, Filter, Plus, Calendar, Users, MoreHorizontal, CheckCircle } from "lucide-react"
import Link from "next/link"

export default function ProjectsPage() {
  const [searchTerm, setSearchTerm] = useState("")
  const [projects, setProjects] = useState([
    {
      id: 1,
      name: "Website Redesign",
      description: "Complete overhaul of company website with modern design",
      progress: 75,
      status: "In Progress",
      dueDate: "2024-02-15",
      team: 5,
      tasks: { total: 24, completed: 18 },
    },
    {
      id: 2,
      name: "Mobile App Development",
      description: "Native iOS and Android app for customer engagement",
      progress: 45,
      status: "In Progress",
      dueDate: "2024-03-01",
      team: 3,
      tasks: { total: 32, completed: 14 },
    },
    {
      id: 3,
      name: "Marketing Campaign",
      description: "Q1 digital marketing campaign across all channels",
      progress: 90,
      status: "Review",
      dueDate: "2024-01-30",
      team: 4,
      tasks: { total: 16, completed: 14 },
    },
    {
      id: 4,
      name: "Database Migration",
      description: "Migrate legacy database to cloud infrastructure",
      progress: 100,
      status: "Completed",
      dueDate: "2024-01-15",
      team: 2,
      tasks: { total: 12, completed: 12 },
    },
    {
      id: 5,
      name: "API Integration",
      description: "Integrate third-party APIs for enhanced functionality",
      progress: 25,
      status: "Planning",
      dueDate: "2024-04-01",
      team: 3,
      tasks: { total: 20, completed: 5 },
    },
    {
      id: 6,
      name: "Security Audit",
      description: "Comprehensive security review and implementation",
      progress: 60,
      status: "In Progress",
      dueDate: "2024-02-28",
      team: 2,
      tasks: { total: 15, completed: 9 },
    },
  ])

  const getStatusColor = (status) => {
    switch (status) {
      case "Completed":
        return "bg-green-100 text-green-800"
      case "In Progress":
        return "bg-blue-100 text-blue-800"
      case "Review":
        return "bg-yellow-100 text-yellow-800"
      case "Planning":
        return "bg-purple-100 text-purple-800"
      default:
        return "bg-gray-100 text-gray-800"
    }
  }

  const filteredProjects = projects.filter(
    (project) =>
      project.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      project.description.toLowerCase().includes(searchTerm.toLowerCase()),
  )

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white border-b">
        <div className="px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-4">
              <CheckCircle className="h-8 w-8 text-blue-600" />
              <div>
                <h1 className="text-2xl font-bold text-gray-900">Projects</h1>
                <p className="text-gray-600">Manage and track all your projects</p>
              </div>
            </div>
            <Button asChild>
              <Link href="/projects/new">
                <Plus className="h-4 w-4 mr-2" />
                New Project
              </Link>
            </Button>
          </div>
        </div>
      </header>

      <div className="p-6">
        {/* Search and Filter */}
        <div className="flex items-center space-x-4 mb-6">
          <div className="relative flex-1 max-w-md">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
            <Input
              placeholder="Search projects..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10"
            />
          </div>
          <Button variant="outline">
            <Filter className="h-4 w-4 mr-2" />
            Filter
          </Button>
        </div>

        {/* Projects Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredProjects.map((project) => (
            <Card key={project.id} className="hover:shadow-lg transition-shadow cursor-pointer">
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <CardTitle className="text-lg">{project.name}</CardTitle>
                    <CardDescription className="mt-2">{project.description}</CardDescription>
                  </div>
                  <Button variant="ghost" size="sm">
                    <MoreHorizontal className="h-4 w-4" />
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {/* Status and Due Date */}
                  <div className="flex items-center justify-between">
                    <Badge className={getStatusColor(project.status)}>{project.status}</Badge>
                    <div className="flex items-center text-sm text-gray-500">
                      <Calendar className="h-4 w-4 mr-1" />
                      {project.dueDate}
                    </div>
                  </div>

                  {/* Progress */}
                  <div>
                    <div className="flex items-center justify-between text-sm mb-2">
                      <span className="font-medium">Progress</span>
                      <span>{project.progress}%</span>
                    </div>
                    <Progress value={project.progress} className="h-2" />
                  </div>

                  {/* Tasks and Team */}
                  <div className="flex items-center justify-between text-sm text-gray-600">
                    <div className="flex items-center">
                      <CheckCircle className="h-4 w-4 mr-1" />
                      {project.tasks.completed}/{project.tasks.total} tasks
                    </div>
                    <div className="flex items-center">
                      <Users className="h-4 w-4 mr-1" />
                      {project.team} members
                    </div>
                  </div>

                  {/* Action Buttons */}
                  <div className="flex space-x-2 pt-2">
                    <Button variant="outline" size="sm" className="flex-1 bg-transparent" asChild>
                      <Link href={`/projects/${project.id}`}>View Details</Link>
                    </Button>
                    <Button size="sm" className="flex-1" asChild>
                      <Link href={`/projects/${project.id}/tasks`}>View Tasks</Link>
                    </Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {filteredProjects.length === 0 && (
          <div className="text-center py-12">
            <div className="text-gray-400 mb-4">
              <Search className="h-12 w-12 mx-auto" />
            </div>
            <h3 className="text-lg font-medium text-gray-900 mb-2">No projects found</h3>
            <p className="text-gray-600 mb-4">
              {searchTerm ? "Try adjusting your search terms" : "Get started by creating your first project"}
            </p>
            <Button asChild>
              <Link href="/projects/new">
                <Plus className="h-4 w-4 mr-2" />
                Create Project
              </Link>
            </Button>
          </div>
        )}
      </div>
    </div>
  )
}
